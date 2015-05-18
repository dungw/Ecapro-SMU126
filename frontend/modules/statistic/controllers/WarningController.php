<?php
namespace frontend\modules\statistic\controllers;

use \Yii;
use yii\db\Query;
use common\controllers\BaseController;
use common\components\helpers\Convert;
use common\models\Warning;
use common\models\Area;
use common\models\Role;
use common\models\Station;

class WarningController extends BaseController {

    public $layout = '//main';

    public function actionIndex() {

        // get station ids by role
        $permCondition = [];
        $role = new Role();
        if (!$role->isAdministrator) {
            $stationIds = Station::getByRole($role->getPosition(), Yii::$app->user->id);
            $permCondition['s.id'] = $stationIds;
        }

        // default time points
        $timePoints = Convert::currentTimePoints();

        // get post form data
        $get = Yii::$app->request->get('get_by');
        if ($get == 'today') {
            $timePoints = Convert::currentTimePoints();
        } else if ($get == 'week') {
            $timePoints = Convert::currentWeekTimePoints();
        } else if ($get == 'month') {
            $timePoints = Convert::currentMonthTimePoints();
        }

        $andWhere = ['>=', 'w.warning_time', $timePoints['start']];
        $andWhere1 = ['<=', 'w.warning_time', $timePoints['end']];

        // get data
        $query = new Query();
        $warnings = $query->select('w.warning_time, s.area_id')
            ->from('warning w')
            ->innerJoin('station s', 'w.station_id = s.id')
            ->where($permCondition)
            ->andWhere($andWhere)
            ->andWhere($andWhere1)
            ->all();

        // data
        $parseData = [];
        $data = [];

        // get areas
        $areaQuery = new Query();
        $areas = $areaQuery->select('a.*')
            ->from('area a')
            ->innerJoin('station s', 's.area_id = a.id')
            ->where($permCondition)
            ->groupBy('a.id')
            ->all();

        $parseData['areas'] = $areas;

        if (!empty($areas)) {
            foreach ($areas as $area) {

                $data[$area['id']]['number'] = 0;
                $data[$area['id']]['start'] = 0;
                $data[$area['id']]['end'] = 0;

                if (!empty($warnings)) {
                    $no = 1;
                    foreach ($warnings as $w) {
                        if ($w['area_id'] == $area['id']) {

                            $data[$area['id']]['number']++;

                            if ($no == 1) {
                                $data[$area['id']]['start'] = $w['warning_time'];
                                $data[$area['id']]['end'] = $w['warning_time'];
                            } else {
                                if ($w['warning_time'] < $data[$area['id']]['start']) {
                                    $data[$area['id']]['start'] = $w['warning_time'];
                                }
                                if ($w['warning_time'] > $data[$area['id']]['end']) {
                                    $data[$area['id']]['end'] = $w['warning_time'];
                                }
                            }

                            $no++;
                        }

                    }
                }
            }
        }

        $parseData['data'] = $data;

        return $this->render('warning', $parseData);
    }

}
