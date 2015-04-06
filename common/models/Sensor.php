<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "sensor".
 *
 * @property integer $id
 * @property string $name
 *
 * @property SensorStatus[] $sensorStatuses
 */
class Sensor extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'sensor';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['name'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Name',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getSensorStatuses()
    {
        return $this->hasMany(SensorStatus::className(), ['sensor_id' => 'id']);
    }
}
