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
            [['sensor_id'], 'required'],
            [['active', 'sensor_id'], 'integer'],
            [['name', 'message_0', 'message_1'], 'string', 'max' => 255]
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'message_0' => 'Nội dung - 0',
            'message_1' => 'Nội dung - 1',
            'sensor_id' => 'Cảm biến',
            'active' => 'Active',
        ];
    }

    public static function getMessageBySensor($sensorId, $value) {
        if ($sensorId > 0) {
            $message = Message::findOne(['sensor_id' => $sensorId, 'active' => self::STATUS_ACTIVE]);
            if ($value == 1) return $message['message_1'];
            if ($value == 0) return $message['message_0'];
        }
        return 'null';
    }
}
