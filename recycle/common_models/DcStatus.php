<?php

namespace common\models;

use Yii;
use common\models\Base;

/**
 * This is the model class for table "dc_status".
 *
 * @property integer $id
 * @property integer $station_id
 * @property double $voltage
 */
class DcStatus extends Base
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'dc_status';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['station_id'], 'required'],
            [['station_id'], 'integer'],
            [['voltage'], 'number']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'station_id' => 'Station ID',
            'voltage' => 'Voltage',
        ];
    }
}
