<?php
namespace frontend\modules\cronjob\models;

use yii\db\Query;
use yii\db\ActiveRecord;
use common\models\Equipment;
use common\models\Sensor;

class CronjobStationModel extends ActiveRecord {

    public function findEquipmentStatus($idStation) {
        $equips = [];
        if ($idStation > 0) {
            $query = new Query();
            $equips = $query->select('es.*, e.name')
                ->from('equipment_status es')
                ->leftJoin('equipment e', 'e.id = es.equipment_id')
                ->where(['es.station_id' => $idStation])
                ->andWhere(['e.active' => Equipment::STATUS_ACTIVE])
                ->all();
        }

        return $equips;
    }

    public function findDcEquipmentStatus($idStation) {
        $dcEquips = [];
        if ($idStation > 0) {
            $query = new Query();
            $dcEquips = $query->select('es.*')
                ->from('dc_equipment_status es')
                ->leftJoin('dc_equipment e', 'e.id = es.equipment_id')
                ->where(['es.station_id' => $idStation])
                ->all();
        }

        return $dcEquips;
    }

    public function findSensorStatus($idStation) {
        $sensors = [];
        if ($idStation > 0) {
            $query = new Query();
            $sensors = $query->select('sst.sensor_id, sst.value, sst.status, s.type, s.unit_type AS unit, s.name')
                ->from('sensor_status sst')
                ->leftJoin('sensor s', 's.id = sst.sensor_id')
                ->where(['sst.station_id' => $idStation])
                ->andWhere(['s.active' => Sensor::STATUS_ACTIVE])
                ->all();
        }

        return $sensors;
    }

    public function findPowerStatus($idStation) {
        $powerEquips = [];
        if ($idStation > 0) {
            $query = new Query();
            $powerEquips = $query->select('s.*, e.name, e.unit_type')
                ->from('power_status s')
                ->leftJoin('power_equipment e', 'e.id = s.item_id')
                ->where(['s.station_id' => $idStation])
                ->all();
        }

        return $powerEquips;
    }

}