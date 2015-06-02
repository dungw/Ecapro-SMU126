<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "station_status_controller".
 *
 * @property integer $id
 * @property integer $station_id
 * @property integer $output_dec
 * @property integer $configure_dec
 * @property integer $security_mode
 * @property integer $created_at
 * @property integer $updated
 */
class StationStatusController extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'station_status_controller';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['station_id', 'output_dec', 'configure_dec', 'security_mode', 'created_at', 'updated'], 'integer']
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
            'output_dec' => 'Output Dec',
            'configure_dec' => 'Configure Dec',
            'security_mode' => 'Security Mode',
            'created_at' => 'Created At',
            'updated' => 'Updated',
        ];
    }
}
