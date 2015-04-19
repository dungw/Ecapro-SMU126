<?php

namespace common\models;

use Yii;
use common\models\Base;

class Message extends Base
{
    const STATUS_ACTIVE = 1;
    const STATUS_UNACTIVE = 0;

    public $_statusData = [
        self::STATUS_ACTIVE => 'Sử dụng',
        self::STATUS_UNACTIVE => 'Không sử dụng'
    ];

    public static function tableName()
    {
        return 'message';
    }

    public function rules()
    {
        return [
            [['name'], 'required'],
            [['sort', 'active'], 'integer'],
            [['name', 'message_0', 'message_1'], 'string', 'max' => 255]
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Thông báo',
            'sort' => 'Thứ tự (D)',
            'message_0' => 'Nội dung - 0',
            'message_1' => 'Nội dung - 1',
            'active' => 'Active',
        ];
    }
}
