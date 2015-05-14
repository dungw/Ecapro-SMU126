<?php

namespace common\models;

use Yii;
use common\models\Base;
use yii\db\Query;

class Station extends Base
{
    const STATUS_CONNECTED = 1;
    const STATUS_LOST = 0;

    public static $types = [
        ['type' => 1, 'name' => 'BTS có ATS'],
        ['type' => 2, 'name' => 'BTS không có ATS'],
    ];

    public $_statusData = [
        self::STATUS_LOST => 'Mất kết nối',
        self::STATUS_CONNECTED => 'Đang kết nối',
    ];

    // object area
    public $area;

    // object center
    public $center;

    // array equipment id
    public $equipment = [];

    // array power equipment id
    public $power_equipment = [];

    // object dc status
    public $dc_status;

    // array dc equipment status
    public $dc_equip_status;

    // array sensor status
    public $sensor_status;

    public static function tableName()
    {
        return 'station';
    }

    public function rules()
    {
        return [
            [['code', 'name'], 'required'],
            [['center_id', 'area_id', 'type', 'status', 'user_id', 'picture_warning_numb', 'change_equipment_status', 'updated_at'], 'integer'],
            [['addition'], 'string'],
            [['code', 'phone'], 'string', 'max' => 100],
            [['name', 'firmware', 'picture_url', 'video_url', 'address'], 'string', 'max' => 255],
            [['latitude', 'longtitude', 'port'], 'string', 'max' => 20],
            [['email', 'staff', 'ip'], 'string', 'max' => 50],
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
            'staff' => 'Nhân viên trực',
            'equipments' => 'Thiết bị',
            'addition' => 'Thông tin thêm',
            'picture_url' => 'Url chụp ảnh',
            'video_url' => 'Url Video',
            'latitude' => 'Vĩ độ',
            'longtitude' => 'Kinh độ',
            'phone' => 'Số điện thoại',
            'email' => 'Email',
            'status' => 'Trạng thái',
            'picture_warning_numb' => 'Số ảnh cảnh báo',
            'ip' => 'IP của trạm',
            'port' => 'Port của trạm',
            'updated_at' => 'Cập nhật lúc',
            'change_equipment_status' => 'Thay đổi trạng thái thiết bị',
            'address' => 'Địa chỉ',
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

    // get status of station
    public function getStatus($status) {
        $allStatus = $this->_statusData;
        if (isset($allStatus[$status])) return $allStatus[$status];
        return null;
    }

    // get equipment
    public function getEquipment($stationId, $equipments) {
        if ($stationId > 0 && !empty($equipments)) {

            // build query
            $query = new Query;
            $query->select('s.*, e.name')
                ->from('equipment_status s')
                ->innerJoin('equipment e', 'e.id = s.equipment_id')
                ->where(['s.equipment_id' => $equipments, 's.station_id' => $stationId]);

            return $query->all();
        }
        return null;
    }

    // get power equipment
    public function getPowerEquipment($stationId, $ids) {
        if ($stationId > 0 && !empty($ids)) {

            // build query
            $query = new Query;
            $query->select('s.*, e.name, e.unit_type')
                ->from('power_status s')
                ->leftJoin('power_equipment e', 'e.id = s.item_id')
                ->where(['s.item_id' => $ids, 's.station_id' => $stationId]);

            return $query->all();
        }
        return null;
    }
}
