<?php
namespace common\controllers;

use Yii;
use common\controllers\BaseController;
use yii\helpers\Url;

class FrontendController extends BaseController {

    public function init() {
        $controllerId = $this->id;

        if (Yii::$app->user->isGuest && $controllerId != 'site') {
            $this->doLogin();
        }
    }

    public function doLogin() {
        $url = Url::toRoute(['/site/login']);
        $this->redirect($url);
    }

}
