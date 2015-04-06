<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "generator_configuration".
 *
 * @property integer $id
 * @property integer $fuel_min
 * @property string $station_code
 * @property integer $check_start_time
 * @property integer $check_cycle
 * @property integer $check_duration
 * @property double $ac_start_voltage
 * @property double $dc_start_voltage
 * @property double $amperage_max
 * @property integer $pause_duration
 * @property integer $work_duration_max
 * @property integer $priority_option
 */
class Generator extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'generator_configuration';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['fuel_min', 'check_start_time', 'check_cycle', 'check_duration', 'pause_duration', 'work_duration_max', 'priority_option'], 'integer'],
            [['ac_start_voltage', 'dc_start_voltage', 'amperage_max'], 'number'],
            [['station_code'], 'string', 'max' => 100]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fuel_min' => 'Fuel Min',
            'station_code' => 'Station Code',
            'check_start_time' => 'Check Start Time',
            'check_cycle' => 'Check Cycle',
            'check_duration' => 'Check Duration',
            'ac_start_voltage' => 'Ac Start Voltage',
            'dc_start_voltage' => 'Dc Start Voltage',
            'amperage_max' => 'Amperage Max',
            'pause_duration' => 'Pause Duration',
            'work_duration_max' => 'Work Duration Max',
            'priority_option' => 'Priority Option',
        ];
    }
}
