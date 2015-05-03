<?php

namespace common\models;

use Yii;
use common\models\Base;

class PowerEquipment extends Base
{
    const ID_VOLTAGE = 1;
    const ID_CAPACITY = 2;
    const ID_CONSUME = 3;
    const ID_FREQUENCY = 4;

    public static function tableName()
    {
        return 'power_equipment';
    }

    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name', 'unit_type'], 'string', 'max' => 255]
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Tên thiết bị',
            'unit_type' => 'Đơn vị',
        ];
    }

    public function getPowerStatuses()
    {
        return $this->hasMany(PowerStatus::className(), ['item_id' => 'id']);
    }
}
