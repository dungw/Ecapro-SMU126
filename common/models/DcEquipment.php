<?php

namespace common\models;

use Yii;
use common\models\Base;

/**
 * This is the model class for table "dc_equipment".
 *
 * @property integer $id
 * @property string $name
 *
 * @property DcEquipmentStatus[] $dcEquipmentStatuses
 */
class DcEquipment extends Base
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'dc_equipment';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Name',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDcEquipmentStatuses()
    {
        return $this->hasMany(DcEquipmentStatus::className(), ['equipment_id' => 'id']);
    }
}
