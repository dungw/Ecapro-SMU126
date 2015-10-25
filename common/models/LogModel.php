<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "log".
 *
 * @property integer $id
 * @property integer $user_id
 * @property string $action
 * @property integer $time
 */
class LogModel extends Base
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'log';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['user_id', 'time', 'related_id', 'station_id'], 'integer'],
            [['action'], 'string']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'user_id' => 'Người dùng',
            'action' => 'Hoạt động',
            'time' => 'Thời gian',
            'related_id' => 'Thiết bị',
            'station_id' => 'Trạm',
        ];
    }

    public static function _prepareDataSelect($collections, $key, $value, $addFirst = true) {
        $data = [];
        if ($addFirst) $data[0] = 'Chọn hoạt động';
        return parent::_prepareDataSelect($collections, $key, $value, $data);
    }
}
