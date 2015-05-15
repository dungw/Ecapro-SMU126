<?php

namespace common\models;

use Yii;
use common\models\Base;

class Sensor extends Base
{
    const TYPE_VALUE = 2;
    const TYPE_CONFIGURE = 1;

    const ID_SECURITY = 1;
    const ID_TEMPERATURE = 3;
    const ID_HUMIDITY = 4;

    const SECURITY_ON = 1;
    const SECURITY_OFF = 0;

    const STATUS_ACTIVE = 1;
    const STATUS_NOT_ACTIVE = 0;

    public static function getSecurityStatus($status) {
        if ($status == self::SECURITY_ON) return 'Đang bật';
        if ($status == self::SECURITY_OFF) return 'Đang tắt';
    }

    public static function tableName()
    {
        return 'sensor';
    }

    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 255],
            [['binary_pos', 'active'], 'integer'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Name',
        ];
    }

    public function getSensorStatuses()
    {
        return $this->hasMany(SensorStatus::className(), ['sensor_id' => 'id']);
    }

    // prepare data for select box
    public static function _prepareDataSelect($collections, $key, $value) {
        $data[0] = 'Chọn cảm biến';
        return parent::_prepareDataSelect($collections, $key, $value, $data);
    }
}
