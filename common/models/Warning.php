<?php

namespace common\models;

use Yii;
use yii\db\Query;

class Warning extends \yii\db\ActiveRecord
{
    const STATUS_READ = 1;
    const STATUS_UNREAD = 0;

    public static function tableName()
    {
        return 'warning';
    }

    public function rules()
    {
        return [
            [['warning_type', 'station_id', 'warning_time', 'read'], 'integer'],
            [['message'], 'string', 'max' => 255]
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'warning_type' => 'Loại cảnh báo',
            'station_id' => 'Trạm',
            'message' => 'Nội dung cảnh báo',
            'warning_time' => 'Thời gian',
            'read' => 'Xem cảnh báo',
        ];
    }

    public function getWarningType()
    {
        return $this->hasOne(WarningType::className(), ['id' => 'warning_type']);
    }

    public static function findPicture($id) {
        $query = new Query();
        return $query->select('*')
            ->from('warning_picture')
            ->where(['warning_id' => $id])
            ->all();
    }

    public static function getWarning($orderBy, $limit, $conditions = []) {
        $query = new Query();
        $query->select('w.*, s.name AS station_name, a.name AS area_name, c.name AS center_name')
            ->from('warning w')
            ->leftJoin('station s', 's.id = w.station_id')
            ->innerJoin('area a', 's.area_id = a.id')
            ->innerJoin('center c', 'c.id = s.center_id')
            ->where([]);

        if (!empty($conditions)) {
            $oneCondition = 0;
            foreach ($conditions as $con) {
                $query->andWhere($con);
            }
        }
        $query->orderBy($orderBy);

        if ($limit > 0) $query->limit($limit);

        $warnings = $query->all();

        if (!empty($warnings)) {
            foreach ($warnings as $k=>$w) {
                $warnings[$k]['pics'] = self::findPicture($w['id']);
            }
        }

        return $warnings;
    }

}
