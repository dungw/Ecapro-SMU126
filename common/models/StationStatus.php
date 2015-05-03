<?php

namespace common\models;

use Yii;
use common\models\Base;

class StationStatus extends Base
{
    const STATUS_SEND = 2;
    const STATUS_RECEIVED = 1;
    const STATUS_OK = 1;
    const STATUS_FAILED = 0;

    public $_statusData = [
        self::STATUS_RECEIVED => 'Gửi từ trạm',
        self::STATUS_SEND => 'Gửi từ máy chủ'
    ];

    public $_statusConnect = [
        self::STATUS_OK => 'Thành công',
        self::STATUS_FAILED => 'Thất bại',
    ];

    public static function tableName()
    {
        return 'station_status';
    }

    public function rules()
    {
        return [
            [['station_id', 'time_update', 'received', 'status'], 'integer'],
            ['request_string', 'string'],
        ];
    }

    public function getStatus($status = '') {
        foreach ($this->_statusData as $s) {
            if (isset($this->_statusData[$status])) return $this->_statusData[$status];
        }
        return null;
    }

    public function getStatusConnect($status = '') {
        foreach ($this->_statusConnect as $s) {
            if (isset($this->_statusConnect[$status])) return $this->_statusConnect[$status];
        }
        return null;
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'station_id' => 'ID trạm',
            'time_update' => 'Thời gian',
            'request_string' => 'Dữ liệu',
            'received' => 'Địa chỉ',
            'status' => 'Trạng thái',
        ];
    }
}
