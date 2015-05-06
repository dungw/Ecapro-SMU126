<?php
namespace common\models;

use \Yii;
use yii\db\Query;
use common\models\Station;
use common\models\StationStatus;
use common\models\Sensor;
use common\models\SensorStatus;
use common\models\Equipment;
use common\models\EquipmentStatus;

class Client {

    const TIMEOUT = 10;
    const CMD_DISARM = 'disarm';
    const CMD_ARMING = 'arming';
    const CMD_GEN_ON = 'gen_on';
    const CMD_GEN_OFF = 'gen_off';
    const CMD_GEN_AUTO = 'gen_auto';
    const CMD_SMS = 'sms';
    const CMD_REBOOT = 'reboot';
    const RES_STATUS_OK = 'OK';
    const RES_STATUS_FAILED = 'ERROR';

    // id station
    public $id;

    // info of station, inc: host, port, name
    public $info;

    // socket handler
    public $socket;

    // error message
    public $error;

    // return message
    public $returnMessage;

    public function init($id) {
        $this->info['id'] = $id;
        if ($this->getConnectInfo($id)) {
            return $this->connect();
        }
        return false;
    }

    public static function commands() {
        return [
            self::CMD_DISARM => [
                'label' => 'T?t báo ??ng',
                'data0' => 'DISARM',
            ],
            self::CMD_ARMING => [
                'label' => 'B?t báo ??ng',
                'data0' => 'ARMING',
            ],
            self::CMD_SMS => [
                'label' => 'Ki?m tra SMS',
                'data0' => 'SMS'
            ],
            self::CMD_REBOOT => [
                'label' => 'Kh?i ??ng l?i thi?t b?',
                'data0' => 'REBOOT'
            ],
        ];
    }

    public static function getCommand($key) {
        $commands = self::commands();
        if (isset($commands[$key])) return $commands[$key];
        return null;
    }

    public function bindCommand($key, $params = []) {
        $cmd[] = $this->info['code'];
        $cmd[] = $this->info['name'];

        $command = self::getCommand($key);

        if (isset($command['data0']) && $command['data0'] != '') {

            // data 0
            $cmd[] = $command['data0'];

            // params
            $cmd = array_merge($cmd, $params);

        } else {
            $this->error = 'Lệnh thực thi không tồn tại. Vui lòng thử lại';
        }

        return implode('&', $cmd);
    }

    public function connect() {

        // create socket
        $socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
        if ($socket === false) {
            $this->error = "Socket_create() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
            return false;
        }

        // set timeout option
        if (is_resource($socket)) {
            $timeout = array('sec' => self::TIMEOUT, 'usec'=>500000);
            socket_set_option($socket, SOL_SOCKET, SO_RCVTIMEO, $timeout);
        }

        // connect to server
        $result = socket_connect($socket, $this->info['host'], $this->info['port']);
        if ($result === false) {
            $this->error = "socket_connect() failed.\nReason: ($result) " . socket_strerror(socket_last_error($socket)) . "\n";
            return false;
        }

        $this->socket = $socket;
        return true;
    }

    public function send($commandKey, $params = []) {

        // bind command by key
        $command = $this->bindCommand($commandKey, $params);
        var_dump($command);

        // insert to station status table
        $data = [
            'station_id' => $this->info['id'],
            'request_string' => $command,
            'received' => StationStatus::STATUS_SEND,
            'time_update' => time()
        ];
        Yii::$app->db->createCommand()
            ->insert('station_status', $data)
            ->execute();
        $returnId = Yii::$app->db->lastInsertID;

        if ($this->error) {
            $this->returnMessage = $this->handleResponse(self::RES_STATUS_FAILED, $commandKey, $returnId);
        } else {

            // send command to server
            socket_write($this->socket, $command, strlen($command));

            // read the respon of server
            $response = socket_read($this->socket, 2048);

            // handle response
            $this->returnMessage = $this->handleResponse($response, $commandKey, $returnId);
        }

        // close socket
        socket_close($this->socket);
    }

    public function handleResponse($response, $commandKey, $id) {
        $command = self::getCommand($commandKey);

        // successful
        if ($response == self::RES_STATUS_OK) {
            $data = ['status' => StationStatus::STATUS_OK];
            return $command['label'] . ' thành công';
        }

        // failed
        if ($response == self::RES_STATUS_FAILED) {
            $data = ['status' => StationStatus::STATUS_FAILED];
            return $command['label'] . ' thất bại';
        }

        return $response;
    }

    public function getConnectInfo($id) {
        $station = Station::findOne($id);
        if (!$station) $this->error = 'Không tìm thấy thông tin trạm';

        $this->info['code'] = $station['code'];
        $this->info['name'] = $station['name'];
        $this->info['host'] = $station['ip'];
        $this->info['port'] = $station['port'];

        return $station;
    }

    public function sendStatus() {

        // get security mode
        $sen = SensorStatus::findOne(['station_id' => $this->info['id'], 'sensor_id' => Sensor::ID_SECURITY]);
        $securityMode = $sen['value'];

        // status & configure
        $status = [];
        $configure = [];
        $query = new Query();
        $equipStatus = $query->select('es.*, e.binary_pos')
            ->from('equipment_status es')
            ->leftJoin('equipment e', 'e.id = es.equipment_id')
            ->where(['es.station_id' => $this->info['id']])
            ->orderBy('e.binary_pos DESC')
            ->all();

        if (!empty($equipStatus)) {
            foreach ($equipStatus as $e) {
                $status[] = $e['status'];
                $configure[] = $e['configure'];
            }
        }

        // send
        $statusDec = bindec(implode('', $status));
        $configureDec = bindec(implode('', $configure));
        $params = [$statusDec, $configureDec];

        if ($securityMode == Sensor::SECURITY_ON) {
            $this->send(self::CMD_ARMING, $params);
        } else if ($securityMode == SenSor::SECURITY_OFF) {
            $this->send(self::CMD_DISARM, $params);
        }
    }
}