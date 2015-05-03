<?php

namespace common\models;

use Yii;
use common\models\Base;
use common\models\Sensor;

class SensorStatus extends Base
{

    public static function tableName()
    {
        return 'sensor_status';
    }

    public function rules()
    {
        return [
            [['sensor_id'], 'required'],
            [['sensor_id', 'station_id', 'status'], 'integer'],
            [['value'], 'number']
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'sensor_id' => 'Sensor ID',
            'station_id' => 'Station ID',
            'value' => 'Value',
            'status' => 'Status',
        ];
    }

    public function getSensor()
    {
        return $this->hasOne(Sensor::className(), ['id' => 'sensor_id']);
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

    public static function getUnit($type) {
        if ($type == 'temperature') return Yii::$app->params['unit_temperature'];
        if ($type == 'humidity') return Yii::$app->params['unit_humidity'];
        if ($type == 'voltage') return Yii::$app->params['unit_voltage'];
        if ($type == 'amperage') return Yii::$app->params['unit_amperage'];
        if ($type == 'consume') return Yii::$app->params['unit_consume'];
        if ($type == 'frequency') return Yii::$app->params['unit_frequency'];
        if ($type == 'capacity') return Yii::$app->params['unit_capacity'];
    }
}
