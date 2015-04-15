<?php

namespace common\models;

use Yii;
use common\models\Base;

class Sensor extends Base
{

    public static function tableName()
    {
        return 'sensor';
    }

    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 255]
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
}
