<?php

namespace common\models;

use Yii;
use common\models\Base;

class PowerStatus extends Base
{
    public static function tableName()
    {
        return 'power_status';
    }

    public function rules()
    {
        return [
            [['item_id'], 'required'],
            [['item_id', 'station_id'], 'integer'],
            [['status'], 'string', 'max' => 100]
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'item_id' => 'Item ID',
            'station_id' => 'Station ID',
            'status' => 'Status',
        ];
    }

    public function getItem()
    {
        return $this->hasOne(PowerEquipment::className(), ['id' => 'item_id']);
    }
}
