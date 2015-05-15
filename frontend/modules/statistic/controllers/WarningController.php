<?php
namespace frontend\modules\statistic\controllers;

use \Yii;
use yii\db\Query;
use common\controllers\BaseController;
use common\components\helpers\Convert;
use common\models\Warning;
use common\models\Area;

class WarningController extends BaseController {

    public $layout = '//main';

    public function actionIndex() {

        // get station ids by role
        $whereClause = [];
        $session = Yii::$app->session;
        if (isset($session['station_ids'])) {
            $stationIds = $session['station_ids'];
            $whereClause['s.id'] = $stationIds;
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
        $warnings = $query->select('min(w.warning_time) AS start, max(w.warning_time) AS end, count(w.id) AS number, a.id AS area_id')
            ->from('warning w')
            ->leftJoin('station s', 'w.station_id = s.id')
            ->leftJoin('area a', 'a.id = s.area_id')
            ->where($whereClause)
            ->andWhere($andWhere)
            ->andWhere($andWhere1)
            ->groupBy('a.id')
            ->all();

        // data
        $parseData = [];
        $data = [];

        // get areas
        $areas = Area::find()->all();
        $parseData['areas'] = $areas;
        if (!empty($areas)) {
            foreach ($areas as $area) {

                $data[$area['id']]['number'] = 0;
                $data[$area['id']]['start'] = 0;
                $data[$area['id']]['end'] = 0;

                if (!empty($warnings)) {
                    foreach ($warnings as $w) {
                        if ($w['area_id'] == $area['id']) {

                            $data[$area['id']]['number'] = $w['number'];
                            $data[$area['id']]['start'] = $w['start'];
                            $data[$area['id']]['end'] = $w['end'];

                        }
                    }
                }
            }
        }

        $parseData['data'] = $data;

        return $this->render('warning', $parseData);
    }

}
