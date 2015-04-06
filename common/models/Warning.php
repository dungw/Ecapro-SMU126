<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "warning".
 *
 * @property integer $id
 * @property integer $warning_type
 * @property integer $station_id
 * @property string $message
 * @property string $picture
 * @property integer $warning_time
 *
 * @property WarningType $warningType
 */
class Warning extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'warning';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['warning_type', 'station_id', 'warning_time'], 'integer'],
            [['message', 'picture'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'warning_type' => 'Warning Type',
            'station_id' => 'Station ID',
            'message' => 'Message',
            'picture' => 'Picture',
            'warning_time' => 'Warning Time',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getWarningType()
    {
        return $this->hasOne(WarningType::className(), ['id' => 'warning_type']);
    }
}
