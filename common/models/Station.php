<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "station".
 *
 * @property integer $id
 * @property string $code
 * @property string $name
 * @property integer $center_id
 * @property integer $area_id
 * @property integer $type
 * @property string $firmware
 * @property integer $staff_id
 * @property string $power_type
 * @property string $pbx_type
 * @property string $transmission_type
 * @property string $accu_type
 * @property string $accu_capacity
 * @property string $generator_type
 * @property string $generator_capacity
 * @property string $addition
 * @property string $picture_ip
 * @property string $video_ip
 * @property string $latitude
 * @property string $longtitude
 * @property string $phone
 * @property string $email
 *
 * @property EquipmentStatus[] $equipmentStatuses
 * @property Area $area
 * @property Center $center
 */
class Station extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'station';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['code', 'name'], 'required'],
            [['center_id', 'area_id', 'type', 'staff_id'], 'integer'],
            [['addition'], 'string'],
            [['code', 'power_type', 'pbx_type', 'transmission_type', 'accu_type', 'accu_capacity', 'generator_type', 'generator_capacity', 'phone'], 'string', 'max' => 100],
            [['name', 'firmware'], 'string', 'max' => 255],
            [['picture_ip', 'video_ip', 'latitude', 'longtitude'], 'string', 'max' => 20],
            [['email'], 'string', 'max' => 50],
            [['code'], 'unique']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'code' => 'Code',
            'name' => 'Name',
            'center_id' => 'Center ID',
            'area_id' => 'Area ID',
            'type' => 'Type',
            'firmware' => 'Firmware',
            'staff_id' => 'Staff ID',
            'power_type' => 'Power Type',
            'pbx_type' => 'Pbx Type',
            'transmission_type' => 'Transmission Type',
            'accu_type' => 'Accu Type',
            'accu_capacity' => 'Accu Capacity',
            'generator_type' => 'Generator Type',
            'generator_capacity' => 'Generator Capacity',
            'addition' => 'Addition',
            'picture_ip' => 'Picture Ip',
            'video_ip' => 'Video Ip',
            'latitude' => 'Latitude',
            'longtitude' => 'Longtitude',
            'phone' => 'Phone',
            'email' => 'Email',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getEquipmentStatuses()
    {
        return $this->hasMany(EquipmentStatus::className(), ['station_code' => 'code']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getArea()
    {
        return $this->hasOne(Area::className(), ['id' => 'area_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getCenter()
    {
        return $this->hasOne(Center::className(), ['id' => 'center_id']);
    }
}
