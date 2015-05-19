<?php
namespace frontend\modules\cronjob\models;

use yii\db\Query;
use yii\db\ActiveRecord;
use common\models\Equipment;

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
            $dcEquips = $query->select('ds.*')
                ->from('dc_equipment_status')
                ->where

        }

        return $dcEquips;
    }

}