<?php

namespace common\models;

use Yii;
use common\models\Base;

class StationStatus extends Base
{
    public static function tableName()
    {
        return 'station_status';
    }

    public function rules()
    {
        return [
            [['station_id', 'time_update', 'input_data', 'output_data'], 'integer']
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'station_id' => 'ID trạm',
            'time_update' => 'Thời gian',
            'input_data' => 'Trạng thái đầu vào',
            'output_data' => 'Trạng thái điều ra',
        ];
    }
}
