<?php
namespace console\controllers;

use yii\console\Controller;
use console\models\SocketServer;

error_reporting(0);

class ServerController extends Controller {

    public $ip = '192.168.1.88';
    public $port = '31337';
    public $maxClient = 100000;

    public function actionIndex() {
        $server = new SocketServer($this->ip, $this->port);
        $server->max_clients = $this->maxClient;
        $server->hook("INPUT", "handle_input");
        $server->infinite_loop();
    }

}