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
        $role = new Role();
        $position = $role->getPosition();

        if (Yii::$app->user->isGuest) {
            $this->doLogin();
        }

        // search model
        $searchModel = new StationSearch();
        $parseData['searchModel'] = $searchModel;

        // get latest warning
        if ($position != Role::POSITION_ADMINISTRATOR) {
            $stationIds = Station::getByRole($position, Yii::$app->user->id);
            $condition = ['in', 'station_id', $stationIds];
            $parseData['warnings'] = Warning::getWarning('warning_time DESC', 5, [$condition]);
        } else {
            $parseData['warnings'] = Warning::getWarning('warning_time DESC', 5, []);
        }

        // get stations
        if ($position != Role::POSITION_ADMINISTRATOR) {
            $sCondition = ['in', 'id', $stationIds];
        } else {
            $sCondition = [];
        }

        // data provider
        $data = $searchModel->search(Yii::$app->request->queryParams, $sCondition);
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
