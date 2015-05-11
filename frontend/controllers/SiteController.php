<?php
namespace frontend\controllers;

use Yii;
use common\models\LoginForm;
use common\models\Station;
use common\models\Role;
use common\models\User;
use common\models\Warning;
use common\models\StationSearch;
use common\controllers\FrontendController;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;

class SiteController extends FrontendController
{

    public $layout = '//main';

    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout', 'signup'],
                'rules' => [
                    [
                        'actions' => ['signup'],
                        'allow' => true,
                        'roles' => ['?'],
                    ],
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    public function actionIndex()
    {
        if (Yii::$app->user->isGuest) {
            $this->doLogin();
        }

        // search model
        $searchModel = new StationSearch();
        $parseData['searchModel'] = $searchModel;

        // get latest warning
        $condition = isset(Yii::$app->session['station_ids']) ? ['station_id' => Yii::$app->session['station_ids']] : [];
        $parseData['warnings'] = Warning::getWarning('warning_time DESC', 5, $condition);

        // get stations
        $stationCondition = isset(Yii::$app->session['station_ids']) ? ['id' => Yii::$app->session['station_ids']] : [];

        // data provider
        $data = $searchModel->search(Yii::$app->request->queryParams, $stationCondition);
        $parseData['stationProvider'] = $data['provider'];

        // write station locator for map
        $this->writeStationLocator($data['query']);
        return $this->render('index', $parseData);
    }

    public function actionLogin()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {

            // open session application
            $session = Yii::$app->session;
            $session->open();

            // set session
            $role = new Role();
            $session['user_position'] = $role->getPosition();

            // set station belong ids
            if ($session['user_position'] == Role::POSITION_ADMIN) {
                $collections = Station::findAll(['user_id' => Yii::$app->user->id]);
                $session['station_ids'] = $this->getIds($collections);

                // get user belong
                $collections = User::findAll(['created_by' => Yii::$app->user->id]);
                $session['user_ids'] = $this->getIds($collections);
            }
            else if ($session['user_position'] == Role::POSITION_OBSERVER) {
                $owner = User::findOne(Yii::$app->user->id);
                $collections = Station::findAll(['user_id' => $owner->getAttribute('created_by')]);
                $session['station_ids'] = $this->getIds($collections);
            }

            return $this->goBack();
        } else {

            $this->layout = '//login';
            return $this->render('login', [
                'model' => $model,
            ]);
        }
    }

    public function getIds($collections) {
        $ids = [];
        if (!empty($collections)) {
            foreach ($collections as $co) {
                $ids[] = $co->id;
            }
        }
        return $ids;
    }

    public function actionLogout()
    {
        Yii::$app->user->logout();
        return $this->goHome();
    }

    // put station locator to locator file in json type
    public function writeStationLocator($query) {
        $stations = $query->all();
        $data = [];
        if (!empty($stations)) {
            foreach ($stations as $station) {
                $color = '';
                $status = $station->getStatus($station->status);
                if ($station->status == Station::STATUS_CONNECTED) {
                    $color = Yii::$app->params['color_of_good'];
                } else if ($station->status == Station::STATUS_LOST) {
                    $color = Yii::$app->params['color_of_bad'];
                }

                $data[] = [
                    'id' => $station->id,
                    'name' => $station->name,
                    'lat' => $station->latitude,
                    'lng' => $station->longtitude,
                    'status' => $status,
                    'color' => $color,
                    'address' => $station->address,
                ];
            }
        }
        $json = json_encode($data);
        $handle = fopen('locations.json', 'r+');
        fwrite($handle, $json);
        fclose($handle);
        file_put_contents('locations.json', $json);
    }

}
