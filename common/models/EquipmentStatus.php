<?php

namespace common\models;

use Yii;
use common\models\Base;
use common\components\helpers\Convert;
use yii\db\Query;

class EquipmentStatus extends Base
{
    const ACTIVE = 1;
    const INACTIVE = 0;
    const STATUS_OFF = 0;
    const STATUS_ON = 1;
    const CONFIGURE_AUTO = 0;
    const CONFIGURE_MANUAL = 1;

    public static function getStatus($feeling) {
        $allStatus = [
            0 => 'Đang tắt',
            1 => 'Đang bật',
        ];
        if (isset($allStatus[$feeling])) {
            return $allStatus[$feeling];
        }
        return null;
    }

    public static function tableName()
    {
        return 'equipment_status';
    }

    public function rules()
    {
        return [
            [['equipment_id', 'station_code', 'station_id'], 'required'],
            [['equipment_id', 'last_update', 'status', 'configure', 'active'], 'integer'],
            [['station_code'], 'string', 'max' => 100]
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'equipment_id' => 'Equipment ID',
            'station_code' => 'Station Code',
            'last_update' => 'Last Update',
            'status' => 'Status',
            'configure' => 'Configure',
            'active' => 'Active',
        ];
    }

    public function getStationCode()
    {
        return $this->hasOne(Station::className(), ['code' => 'station_code']);
    }

    // update equipment status
    public function updateStatus($stationId, $decimal) {
        $binary = Convert::dec2Bin($decimal, 10);

        // get equipments
        $query = new Query;

        $query->select('b1.*, b2.sort')
            ->from('equipment_status b1')
            ->leftJoin('equipment b2', 'b1.equipment_id = b2.id')
            ->where(['station_id' => $stationId]);

        $equipments = $query->createCommand()->queryAll();

        if (!empty($equipments)) {
            foreach ($equipments as $e) {
                Yii::$app->db->createCommand()
                    ->update('equipment_status', ['status' => $binary[$e['sort']]], [
                        'station_id' => $stationId,
                        'equipment_id' => $e['equipment_id']]
                    )->execute();
            }
        }
    }
}
