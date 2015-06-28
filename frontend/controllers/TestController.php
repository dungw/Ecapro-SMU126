<?php
namespace frontend\controllers;

use Yii;
use yii\base\Exception;
use yii\web\Controller;
use common\models\Observer;
use common\models\Client;
use common\components\helpers\Convert;

class TestController extends Controller {

    public function actionIndex() {
        $id = 1;
        $value = call_user_func('before', $id);
        var_dump($value);
    }

    public function actionCamera()
    {
        $url = 'http://ecasmart.homelinux.com:8888/videostream.cgi?rate=0&user=ecaprovn&pwd=1q2w3e4r';
        $response = file_get_contents($url);
        print '<pre>';
        print_r($response);
    }

    public function before($id)
    {
        return $id+1;
    }

    public function actionAlarm() {
        $requestString = '123&Tram_so_1&alarm&mat dien luoi';
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
	
        //$client->sendStatus();

//        if (!$res) {
//            print $client->error;
//        } else {
//            $client->send('sms', ['phone' => '0906600788', 'message' => 'how is the work?']);
//            print $client->returnMessage;
//        }

	$data0 = Yii::$app->request->get('data0');
	$data1 = Yii::$app->request->get('data1');
	$data2 = Yii::$app->request->get('data2');
	$client->send($data0, [$data1, $data2]);
	print $client->returnMessage;
    }

}
