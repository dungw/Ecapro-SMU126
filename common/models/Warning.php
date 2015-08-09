<?php

namespace common\models;

use Yii;
use yii\db\Query;
use common\components\helpers\Convert;

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
            [['station_id', 'warning_time', 'read'], 'integer'],
            [['message'], 'string', 'max' => 255]
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'station_id' => 'Trạm',
            'message' => 'Nội dung cảnh báo',
            'warning_time' => 'Thời gian',
            'read' => 'Xem cảnh báo',
        ];
    }

    public static function findPicture($id) {
        $query = new Query();
        return $query->select('*')
            ->from('warning_picture')
            ->where(['warning_id' => $id])
            ->all();
    }

    public static function deletePicture($warningID) {
        if ($warningID > 0) {

            //select from db
            $pictures = self::findPicture($warningID);
            if (!empty($pictures)) {
                foreach ($pictures as $pic) {
                    $path = $_SERVER['DOCUMENT_ROOT'] . '/frontend/web/uploads/' . $pic['picture'];
                    if (file_exists($path)) {
                        unlink($path);
                    }
                }
            }

            //delete in db
            Yii::$app->db->createCommand()
                ->delete('warning_picture', ['warning_id' => $warningID])
                ->execute();

            return true;
        }
        return false;
    }

    public static function multipleDelete($params)
    {
        //build conditions
        $conditions = [];
        if (isset($params['from_date']) && trim($params['from_date']) !== '') {
            $fromTime = Convert::date2Time($params['from_date'], 'd/m/Y');
            $conditions[] = "w.warning_time >= ". $fromTime;
        }

        if (isset($params['to_date']) && trim($params['to_date']) !== '') {
            $toTime = Convert::date2Time($params['to_date'], 'd/m/Y');
            $conditions[] = "w.warning_time <= ". $toTime;
        }

        if (isset($params['station']) && !empty($params['station'])) {
            $conditions[] = "s.id IN(". implode(',', $params['station']) .")";
        }

        if (isset($params['area_id']) && $params['area_id'] > 0) {
            $conditions[] = "s.area_id = ". $params['area_id'];
        }

        if (isset($params['center_id']) && $params['center_id'] > 0) {
            $conditions[] = "s.center_id = ". $params['center_id'];
        }

        //delete real pictures
        $sql = "SELECT p.picture
                FROM warning_picture p
                INNER JOIN warning w ON(w.id = p.warning_id)
                INNER JOIN station s ON(s.id = w.station_id)
                WHERE 1";

        if (!empty($conditions)) $sql .= " AND " . implode(' AND ', $conditions);

        $pictures = Yii::$app->db->createCommand($sql)->queryAll();
        if (!empty($pictures)) {
            foreach ($pictures as $pic) {
                $path = $_SERVER['DOCUMENT_ROOT'] . '/frontend/web/uploads/' . $pic['picture'];
                if (file_exists($path)) {
                    unlink($path);
                }
            }
        }

        //delete warning picture in db
        $sql = "DELETE p
                FROM warning_picture p
                INNER JOIN warning w ON(w.id = p.warning_id)
                INNER JOIN station s ON(s.id = w.station_id)
                WHERE 1";

        if (!empty($conditions)) $sql .= ' AND ' . implode(' AND ', $conditions);
        Yii::$app->db->createCommand($sql)->execute();

        //delete warning in db
        $sql = "DELETE w
                FROM warning w
                INNER JOIN station s ON(s.id = w.station_id)
                WHERE 1";

        if (!empty($conditions)) $sql .= ' AND ' . implode(' AND ', $conditions);
        Yii::$app->db->createCommand($sql)->execute();
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
