<?php

namespace common\models;

use Yii;

class StationStatusHandler extends \yii\db\ActiveRecord
{
    const TYPE_EQUIPMENT = 1;
    const TYPE_SENSOR_SECURITY = 2;
    const STATUS_UPDATED = 1;
    const STATUS_NOT_UPDATE = 0;

    public static function tableName()
    {
        return 'station_status_handler';
    }

    public function rules()
    {
        return [
            [['equip_id', 'station_id', 'type', 'status', 'configure', 'updated', 'created_at'], 'integer']
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'equip_id' => 'Equip ID',
            'station_id' => 'Station ID',
            'type' => 'Type',
            'status' => 'Status',
            'configure' => 'Configure',
            'updated' => 'Updated',
            'created_at' => 'Created At',
        ];
    }
}
