<?php
namespace frontend\controllers;

use Yii;
use yii\web\Controller;
use common\models\Observer;
use common\models\Client;
use common\components\helpers\Convert;

class TestController extends Controller {

    public function actionIndex() {
        var_dump(Convert::dec2Bin(8, 10));
        var_dump(Convert::dec2Bin(5, 10));
    }

    public function actionAlarm() {
        $requestString = '533db2&Tram_so_1&alarm&mat dien luoi';
        $observer = new Observer();
        $observer->handleRequest($requestString);
    }

    public function actionStatus() {
        $requestString = '533db2&Tram_so_1&status&1&6&32';
        $observer = new Observer();
        $observer->handleRequest($requestString);
    }

    public function actionSend() {
        $client = new Client();
        $res = $client->init(13);
        if (!$res) {
            print $client->error;
        } else {
            $client->send('sms', ['phone' => '0906600788', 'message' => 'how is the work?']);
            print $client->returnMessage;
        }
    }

}
