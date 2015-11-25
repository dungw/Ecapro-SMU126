<?php
namespace frontend\controllers;

use Yii;
use yii\base\Exception;
use yii\web\Controller;
use common\models\Observer;
use common\models\Client;
use common\components\helpers\Convert;

class TestController extends Controller
{

    public function actionIndex()
    {
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
        return $id + 1;
    }

    public function actionAlarm()
    {
        $requestString = '123&Tram_so_1&alarm&mat dien luoi';
        $observer = new Observer();
        $observer->handleRequest($requestString);
    }

    public function actionStatus()
    {
	    $items = [
		    0   => '123',
		    1   => 'Tram_so_1',
		    2   => 'status',
		    3   => 'DISARM',
		    4   => '1',
		    5   => '6',
		    6   => '32',
		    7   => '15',
		    8   => '12',
		    9   => 'p1',
		    10   => 'p2',
		    11   => 'p3',
		    12   => 'p4',
		    13   => 'p5',
		    14   => 'p6',

		    15   => '1',
		    16   => '2',
		    17   => '3',
		    18   => '4',
	    ];
        $requestString = implode('&', $items);
        $observer = new Observer();
        $observer->handleRequest($requestString);
    }

}
