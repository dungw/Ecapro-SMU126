<?php

namespace common\models;

use Yii;
use common\models\Base;
use common\models\DcEquipment;
use yii\db\Query;

/**
 * This is the model class for table "dc_equipment_status".
 *
 * @property integer $id
 * @property integer $equipment_id
 * @property double $amperage
 * @property double $voltage
 * @property double $temperature
 * @property integer $station_id
 * @property integer $status
 *
 * @property DcEquipment $equipment
 */
class DcEquipmentStatus extends Base
{

    public static function tableName()
    {
        return 'dc_equipment_status';
    }

    public function rules()
    {
        return [
            [['equipment_id', 'station_id', 'status'], 'integer'],
            [['amperage', 'voltage', 'temperature'], 'number']
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'equipment_id' => 'Equipment ID',
            'amperage' => 'Amperage',
            'voltage' => 'Voltage',
            'temperature' => 'Temperature',
            'station_id' => 'Station ID',
            'status' => 'Status',
        ];
    }

    public function getEquipment()
    {
        return $this->hasOne(DcEquipment::className(), ['id' => 'equipment_id']);
    }

    public static function getStatus($feeling) {
        $allStatus = [
            0 => 'Chưa xác định',
            1 => 'Bình thường',
        ];
        if (isset($allStatus[$feeling])) {
            return $allStatus[$feeling];
        }
        return null;
    }

    public static function findByStation($stationId) {
        if ($stationId > 0) {
            $query = new Query();
            $data = $query->select('ds.*, de.name, de.unit_voltage, de.unit_amperage')
                ->from('dc_equipment_status ds')
                ->innerJoin('dc_equipment de', 'de.id = ds.equipment_id')
                ->where(['ds.station_id' => $stationId])
                ->andWhere(['de.active' => DcEquipment::STATUS_ACTIVE])
                ->all();

            return $data;
        }
    }
}
