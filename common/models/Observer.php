<?php
namespace common\models;

use \Yii;
use yii\db\Query;
use yii\helpers\VarDumper;
use common\components\helpers\Convert;
use common\models\Station;
use common\models\SensorStatus;
use common\models\PowerEquipment;
use common\models\PowerStatus;
use common\models\DcEquipmentStatus;
use common\models\DcEquipment;
use common\models\StationStatus;
use common\models\Snapshot;
use common\models\Warning;

class Observer {

    const FUNCTION_STATUS = 'status';
    const FUNCTION_ALARM = 'alarm';
    const BINARY_LENGTH = 10;

    // begin start equipments
    const MSG_BEGIN = 'Begin';

    // received directive from server succesful
    const MSG_OK = 'OK';

    // received invalid data from server
    const MSG_ERROR = 'ERROR';

    // security mode off
    const MSG_DISARM = 'DISARM';

    // security mode on
    const MSG_ARMING = 'ARMING';

    // request info
    public $request;

    // Main function: handle all request from station
    public function handleRequest($requestString) {
        if (!trim($requestString)) return 'Invalid request string';

        if (!$this->analyzeRequestString($requestString)) return 'Cannot handle request string';

        // do update station status
        if ($this->request['function'] == self::FUNCTION_STATUS) $this->update();

        // do alarm
        if ($this->request['function'] == self::FUNCTION_ALARM) $this->alarm();

        // update station status
        $this->updateStationStatus();

        // after handle request
        return $this->afterHandle();
    }

    public function alarm() {

        // insert warning
        $id = $this->insertWarning();

        // get station info
        $station = $this->findStation($this->request['id']);

        // snapshot info
        $snapUrl = $station['picture_url'];

        // take pictures and save to database
        $batch = [];
        $snapshot = new Snapshot();
        $snapshot->init($snapUrl);
        $pics = $snapshot->takes($station['picture_warning_numb']);
        if (!empty($pics)) {
            foreach ($pics as $pic) {
                $batch[] = [$id, $pic, time()];
            }
            Yii::$app->db->createCommand()
                ->batchInsert('warning_picture', ['warning_id', 'picture', 'created_at'], $batch)
                ->execute();
        }
    }

    public function update() {
        $station = $this->findStation($this->request['id']);
        if (!$station) return 'Cannot find station';

        // update sensor
        $this->updateSensor();

        // update equipment status with output status and configure status
        $this->updateEquipmentStatus();

        // update power status
        $this->updatePowerStatus();

        // update dc status
        $this->updateDcStatus();

    }

    public function insertWarning() {
        $warning = new Warning();

        $warning->station_id = $this->request['id'];
        $warning->message = $this->request['message'];
        $warning->warning_type = 1;
        $warning->warning_time = time();
        if ($warning->validate()) {
            $warning->save();
        } else {
            var_dump($warning->getErrors());die;
        }

        return Yii::$app->db->lastInsertID;
    }

    public function updateStationStatus() {
        $model = new StationStatus();
        $model->station_id = $this->request['id'];
        $model->request_string = $this->request['data'];
        $model->time_update = time();
        $model->save();
    }

    public function updateDcStatus() {

        // get all dc equipment of this station
        $dcEquips = DcEquipmentStatus::findAll(['station_id' => $this->request['id']]);
        if (!empty($dcEquips)) {
            foreach ($dcEquips as $equip) {
                $value = [];

                // if this is dc 1
                if ($equip['equipment_id'] == DcEquipment::ID_DC1) {
                    $value = [
                        'voltage' => $this->request['dc1_voltage'],
                        'amperage' => $this->request['dc1_ampe'],
                    ];
                }

                // if this is dc 2
                if ($equip['equipment_id'] == DcEquipment::ID_DC2) {
                    $value = [
                        'voltage' => $this->request['dc2_voltage'],
                        'amperage' => $this->request['dc2_ampe'],
                    ];
                }

                Yii::$app->db->createCommand()
                    ->update('dc_equipment_status', $value, ['id' => $equip['id']])
                    ->execute();
            }
        }
    }

    public function updatePowerStatus() {

        // get all power equipments of this station
        $powerEquips = PowerStatus::findAll(['station_id' => $this->request['id']]);
        if (!empty($powerEquips)) {
            foreach ($powerEquips as $equip) {
                $value = '';
                if ($equip['item_id'] == PowerEquipment::ID_VOLTAGE) $value = $this->request['power_voltage'];
                if ($equip['item_id'] == PowerEquipment::ID_CAPACITY) $value = $this->request['power_capacity'];
                if ($equip['item_id'] == PowerEquipment::ID_CONSUME) $value = $this->request['power_consume'];
                if ($equip['item_id'] == PowerEquipment::ID_FREQUENCY) $value = $this->request['power_frequency'];

                Yii::$app->db->createCommand()
                    ->update('power_status', ['status' => $value], ['id' => $equip['id']])
                    ->execute();
            }
        }
    }

    public function updateEquipmentStatus() {
        $outputBin = Convert::dec2Bin($this->request['output_status'], self::BINARY_LENGTH);
        $configureBin = Convert::dec2Bin($this->request['configure_status'], self::BINARY_LENGTH);

        // get all equipment status of this station
        $query = new Query();
        $equips = $query->select('e.binary_pos, es.id')
            ->from('equipment_status es')
            ->leftJoin('equipment e', 'e.id = es.equipment_id')
            ->where(['station_id' => $this->request['id']])
            ->all();

        if (!empty($equips)) {
            foreach ($equips as $eq) {
                $eq['binary_pos'] = intval($eq['binary_pos']);
                Yii::$app->db->createCommand()
                    ->update('equipment_status', [
                        'status' => $outputBin[$eq['binary_pos']],
                        'configure' => $configureBin[$eq['binary_pos']],
                    ], ['id' => $eq['id']])->execute();
            }
        }
    }

    /**
     * update sensor status with input status
     * - update temperature
     * - update humidity
     * - update security mode
     * - update all sensor equipment
     */
    public function updateSensor() {
        $inputBin = Convert::dec2Bin($this->request['input_status'], self::BINARY_LENGTH);

        // get all sensor status of this station
        $query = new Query();
        $query->select('s.binary_pos, s.type, st.id, st.sensor_id');
        $query->from('sensor_status st');
        $query->leftJoin('sensor s', 'st.sensor_id = s.id');
        $query->where('station_id = '. $this->request['id']);

        $sensors = $query->all();

        if (!empty($sensors)) {
            foreach ($sensors as $sensor) {
                if ($sensor['type'] == Sensor::TYPE_CONFIGURE) {
                    Yii::$app->db->createCommand()
                        ->update('sensor_status', ['value' => $inputBin[$sensor['binary_pos']]], ['id' => $sensor['id']])
                        ->execute();
                } else if ($sensor['type'] == Sensor::TYPE_VALUE) {
                    $value = '';

                    // if this is security mode
                    if ($sensor['sensor_id'] == Sensor::ID_SECURITY) {
                        if ($this->request['message'] == self::MSG_ARMING) $value = 1;
                        if ($this->request['message'] == self::MSG_DISARM) $value = 0;
                    }

                    // if this is temperature
                    if ($sensor['sensor_id'] == Sensor::ID_TEMPERATURE) {
                        $value = $this->request['temp'];
                    }

                    // if this is humidity
                    if ($sensor['sensor_id'] == Sensor::ID_HUMIDITY) {
                        $value = $this->request['humi'];
                    }

                    Yii::$app->db->createCommand()
                        ->update('sensor_status', ['value' => $value], ['id' => $sensor['id']])
                        ->execute();
                }
            }
        }
    }

    public function afterHandle() {

        // return current time to control device
        if ($this->request['message'] == self::MSG_BEGIN) {

        }

        return 'OK';
    }

    public function analyzeRequestString($requestString) {
        $temp = explode('&', $requestString);
        if (!empty($temp)) {
            $this->request['data'] = $requestString;

            $this->request['id'] = $this->findStationId(trim($temp[0]));
            $this->request['name'] = $temp[1];
            $this->request['function'] = $temp[2];
            $this->request['message'] = $temp[3];
            $this->request['input_status'] = isset($temp[4]) ? $temp[4] : '';
            $this->request['output_status'] = isset($temp[5]) ? $temp[5] : '';
            $this->request['configure_status'] = isset($temp[6]) ? $temp[6] : '';
            $this->request['temp'] = isset($temp[7]) ? $temp[7] : '';
            $this->request['humi'] = isset($temp[8]) ? $temp[8] : '';
            $this->request['power_voltage'] = isset($temp[9]) ? $temp[9] : '';
            $this->request['power_capacity'] = isset($temp[10]) ? $temp[10] : '';
            $this->request['power_consume'] = isset($temp[11]) ? $temp[11] : '';
            $this->request['power_frequency'] = isset($temp[12]) ? $temp[12] : '';
            $this->request['dc1_voltage'] = isset($temp[13]) ? $temp[13] : '';
            $this->request['dc2_voltage'] = isset($temp[14]) ? $temp[14] : '';
            $this->request['dc1_ampe'] = isset($temp[15]) ? $temp[15] : '';
            $this->request['dc2_ampe'] = isset($temp[16]) ? $temp[16] : '';

            return true;
        } else {
            return false;
        }
    }

    public function findStationId($code) {
        $station = Station::findOne(['code' => $code]);
        if (!$station) return false;
        return $station['id'];
    }

    public function findStation($id) {
        $station = Station::findOne($id);
        if (!$station) return false;
        return $station;
    }
}