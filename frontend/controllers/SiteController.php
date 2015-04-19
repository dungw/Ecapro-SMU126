<?php
namespace frontend\controllers;

use Yii;
use common\models\LoginForm;
use common\models\Station;
use common\models\Area;
use common\models\Role;
use common\models\User;
use frontend\models\PasswordResetRequestForm;
use frontend\models\ResetPasswordForm;
use frontend\models\SignupForm;
use frontend\models\ContactForm;
use yii\base\InvalidParamException;
use yii\db\Query;
use yii\web\BadRequestHttpException;
use yii\web\Controller;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;

// use Base controller
use common\controllers\FrontendController;

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
        $this->writeStationLocator();
        return $this->render('index');
    }

    public function actionLogin()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {

            // set session
            $role = new Role();
            Yii::$app->session['user_position'] = $role->getPosition();

            // set station belong ids
            if (Yii::$app->session['user_position'] == Role::POSITION_ADMIN) {
                $collections = Station::findAll(['user_id' => Yii::$app->user->id]);
                Yii::$app->session['station_ids'] = $this->getIds($collections);

                // get user belong
                $collections = User::findAll(['created_by' => Yii::$app->user->id]);
                Yii::$app->session['user_ids'] = $this->getIds($collections);
            }
            else if (Yii::$app->session['user_position'] == Role::POSITION_OBSERVER) {
                $owner = User::findOne(Yii::$app->user->id);
                $collections = Station::findAll(['user_id' => $owner->getAttribute('created_by')]);
                Yii::$app->session['station_ids'] = $this->getIds($collections);
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


    // put station locator to locators file in json type
    public function writeStationLocator() {
        $stations = Station::find()->all();
        if (!empty($stations)) {
            foreach ($stations as $station) {
                $area = Area::findOne($station->area_id);
                $data[] = [
                    'id' => $station->id,
                    'name' => $station->name,
                    'lat' => $station->latitude,
                    'lng' => $station->longtitude,
                    'area' => 'Khu vực '.$area->name,
                    'phone' => $station->phone,
                    'detail_url' => '/station/default/view?id='. $station->id,
                ];
            }

            $json = json_encode($data);
            $handle = fopen('locations.json', 'r+');
            fwrite($handle, $json);
            fclose($handle);
            file_put_contents('locations.json', $json);
        }
    }

}
