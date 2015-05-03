<?php

namespace common\models;

use Yii;
use common\models\Base;

class DcEquipment extends Base
{
    const ID_DC1 = 1;
    const ID_DC2 = 2;

    public static function tableName()
    {
        return 'dc_equipment';
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

    public function getDcEquipmentStatuses()
    {
        return $this->hasMany(DcEquipmentStatus::className(), ['equipment_id' => 'id']);
    }
}
