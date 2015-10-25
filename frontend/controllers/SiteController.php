<?php
namespace frontend\controllers;

use common\components\helpers\Log;
use Yii;
use common\models\LoginForm;
use common\models\Station;
use common\models\Role;
use common\models\Warning;
use common\models\StationSearch;
use common\models\Setting;
use common\controllers\FrontendController;
use frontend\models\UpdateInfo;
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
            $parseData['warnings'] = Warning::getWarning('warning_time DESC', 100, [$condition]);
        } else {
            $parseData['warnings'] = Warning::getWarning('warning_time DESC', 100, []);
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
        $this->_writeStationLocator($data['query']);

        return $this->render('index', $parseData);
    }

    public function actionMap()
    {
        return $this->render('map', []);
    }

    public function actionLogin()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {

            //write log action
            Log::logAction(Yii::$app->user->id, Log::ACTION_LOGIN);

            return $this->goBack();
        } else {

            $this->layout = '//login';
            return $this->render('login', [
                'model' => $model,
            ]);
        }
    }

    public function getIds($collections)
    {
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

    public function actionSetting()
    {
        $model = Setting::findOne(['active' => Setting::STATUS_ACTIVE]);
        $parse['model'] = $model;

        //post action
        $posts = Yii::$app->request->post();
        if (!empty($posts)) {
            $model->setServerIP($posts['server_ip']);
            $model->setServerPort($posts['server_port']);
            $model->save();
            Yii::$app->session->setFlash('update_success', 'Cập nhật thành công');

            //update root password
            if (isset($posts['password_root']) && $posts['password_root'] != '******') {
                $root = $model->_getRoot();
                $uiModel = new UpdateInfo();
                $uiModel->username  = $root->username;
                $uiModel->password  = $posts['password_root'];
                $uiModel->fullname  = $root->fullname;
                $uiModel->mobile    = $root->mobile;
                $uiModel->email     = $root->email;
                $uiModel->type      = $root->type;
                if ($uiModel->validate()) {
                    $uiModel->updateInfo($root->id);
                    $this->actionLogout();
                } else {
                    $parse['errors'] = $uiModel->getErrors();
                }
            }
        }

        return $this->render('setting', $parse);
    }

    /* private functions */

    // put station locator to locator file in json type
    private function _writeStationLocator($query)
    {
        $stations = $query->all();
        $data = [];
        if (!empty($stations)) {
            foreach ($stations as $station) {
                $color = '';
                $message = '';
                $status = $station->getStatus($station->status);
                $unreadWarning = $station->hasUnreadWarning($station->id);

                if ($unreadWarning) {
                    $color = 'FFFFAE';
                    $message = $unreadWarning->message;
                } else if ($station->status == Station::STATUS_LOST) {
                    $color = 'FFBFBF';
                } else {
                    $color = 'A6F9A8';
                }

                $data[] = [
                    'id' => $station->id,
                    'name' => $station->name,
                    'lat' => $station->latitude,
                    'lng' => $station->longtitude,
                    'status' => $status,
                    'color' => $color,
                    'address' => $station->address,
                    'message' => $message,
                ];
            }
        }

        if (!is_dir(Yii::$app->basePath . '/web/locations/')) {
            mkdir(Yii::$app->basePath . '/web/locations/');
        }
        $jsonFile = Yii::$app->basePath . '/web/locations/' . Yii::$app->user->id . '.json';
        $json = json_encode($data);
        $handle = fopen($jsonFile, 'w+');
        fwrite($handle, $json);
        fclose($handle);
        file_put_contents($jsonFile, $json);
    }

}
