<?php

namespace common\models;

use Yii;
use common\models\Base;

/**
 * This is the model class for table "dc_equipment".
 *
 * @property integer $id
 * @property string $name
 * @property string $unit_voltage
 * @property string $unit_amperage
 * @property integer $active
 */
class DcEquipment extends Base
{
    const ID_DC1 = 1;
    const ID_DC2 = 2;
    const STATUS_ACTIVE = 1;
    const STATUS_INACTIVE = 0;

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
            [['active'], 'integer'],
            [['name'], 'string', 'max' => 255],
            [['unit_voltage', 'unit_amperage'], 'string', 'max' => 10]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Tên',
            'unit_voltage' => 'Đơn vị điện áp',
            'unit_amperage' => 'Đơn vị dòng điện',
            'active' => 'Active',
        ];
    }

    public function optionStatus()
    {
        return [
            self::STATUS_ACTIVE     => 'Sử dụng',
            self::STATUS_INACTIVE   => 'Không sử dụng',
        ];
    }

    public function getStatusLabel($status) {
        $statuses = $this->optionStatus();
        foreach ($statuses as $key => $value) {
            if ($status == $key) return $value;
        }
    }
}
