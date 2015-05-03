<?php

namespace common\models;

use Yii;
use common\models\Base;

class Equipment extends Base
{
    const STATUS_ACTIVE = 1;

    public static function tableName()
    {
        return 'equipment';
    }

    public function rules()
    {
        return [
            [['name'], 'required'],
            [['active'], 'integer'],
            [['name'], 'string', 'max' => 255],
            [['binary_pos'], 'integer']
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Tên thiết bị',
            'binary_pos' => 'Thứ tự nhị phân',
            'active' => 'Active',
        ];
    }
}
