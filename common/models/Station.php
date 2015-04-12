<?php

namespace common\models;

use Yii;
use common\models\Base;

class Station extends Base
{
    public static $types = [
        ['type' => 1, 'name' => 'BTS có ATS'],
        ['type' => 2, 'name' => 'BTS không có ATS'],
    ];

    // object area
    public $area;

    // object center
    public $center;

    // array equipment id
    public $equipment = [];

    public static function tableName()
    {
        return 'station';
    }

    public function rules()
    {
        return [
            [['code', 'name'], 'required'],
            [['center_id', 'area_id', 'type', 'staff_id'], 'integer'],
            [['addition'], 'string'],
            [['code', 'phone'], 'string', 'max' => 100],
            [['name', 'firmware'], 'string', 'max' => 255],
            [['picture_ip', 'video_ip', 'latitude', 'longtitude'], 'string', 'max' => 20],
            [['email'], 'string', 'max' => 50],
            [['code'], 'unique']
        ];
    }

    // get labels
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'code' => 'Mã trạm',
            'name' => 'Tên trạm',
            'center_id' => 'Trung tâm',
            'area_id' => 'Khu vực',
            'type' => 'Loại trạm',
            'firmware' => 'Firmware',
            'staff_id' => 'Nhân viên trực',
            'equipments' => 'Thiết bị',
            'addition' => 'Thông tin thêm',
            'picture_ip' => 'IP chụp ảnh',
            'video_ip' => 'IP Video',
            'latitude' => 'Vĩ độ',
            'longtitude' => 'Kinh độ',
            'phone' => 'Số điện thoại',
            'email' => 'Email',
        ];
    }

    public function getEquipmentStatuses()
    {
        return $this->hasMany(EquipmentStatus::className(), ['station_code' => 'code']);
    }

    public function getArea()
    {
        return $this->hasOne(Area::className(), ['id' => 'area_id']);
    }

    public function getCenter()
    {
        return $this->hasOne(Center::className(), ['id' => 'center_id']);
    }

    // prepare data for select box
    public static function _prepareDataSelect($collections, $key, $value) {
        $data[0] = 'Chọn loại trạm';
        return parent::_prepareDataSelect($collections, $key, $value, $data);
    }

    // get type of station
    public function getType($type) {
        foreach (self::$types as $t) {
            if ($t['type'] == $type) return $t['name'];
        }

        return null;
    }

    // get equipment
    public function getEquipment($stationId, $equipments) {
        if ($stationId > 0 && !empty($equipments)) {
            $sql = 'SELECT s.*, e.name
                FROM equipment_status s
                LEFT JOIN equipment e ON(e.id = s.equipment_id)
                WHERE s.equipment_id IN('. implode(',', $equipments) .') AND s.station_id = '. $stationId;

            return Yii::$app->db->createCommand($sql)->queryAll();
        }
        return null;
    }
}
