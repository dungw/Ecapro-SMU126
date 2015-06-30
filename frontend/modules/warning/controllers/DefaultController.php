<?php

namespace app\modules\warning\controllers;

use Yii;
use common\models\Warning;
use common\models\Station;
use common\controllers\FrontendController;
use common\components\helpers\Convert;
use common\components\helpers\Show;
use common\models\Role;
use arturoliveira\ExcelView;
use yii\data\ActiveDataProvider;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\db\Query;

class DefaultController extends FrontendController
{
    public $layout = '//main';

    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }

    /**
     * @inheritdoc
     */
    public function beforeAction($action)
    {
        $csrfFalseActions = [
            'actionCronLatest',
            'actionCronUnread',
            'actionRead',
        ];

        if (in_array($action->actionMethod, $csrfFalseActions)) {
            Yii::$app->controller->enableCsrfValidation = false;
        }
        return parent::beforeAction($action);
    }

    public function actionIndex()
    {
        $this->enableCsrfValidation = false;
        $builder = $this->buildQuery();
        $query = $builder['query'];
        $parseData = $builder['parseData'];

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $parseData['dataProvider'] = $dataProvider;

        return $this->render('index', $parseData);
    }

    public function actionExport() {
        $builder = $this->buildQuery(true);
        $query = $builder['query'];

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);
        ExcelView::widget([
            'dataProvider'  => $dataProvider,
            'fullExportType'=> 'xlsx',

            'grid_mode'     => 'export',
            'columns'       => [
                ['class' => 'yii\grid\SerialColumn'],
                [
                    'attribute' => 'station_name',
                    'header'    => 'Tên trạm',
                ],
                [
                    'attribute' => 'message',
                    'header'    => 'Nội dung',
                ],
                [
                    'attribute' => 'warning_date',
                    'header'    => 'Thời gian',
                ],
            ],
        ]);
    }

    private function buildQuery($export = false) {
        $parseData = [];
        if ($export) {
            $query = new Query();
            $query->select(['warning.message AS message', 'station.name AS station_name', 'DATE_FORMAT(FROM_UNIXTIME(warning.warning_time), "%d/%m/%Y") AS warning_date'])
                ->from('warning')
                ->leftJoin('station', 'station.id = warning.station_id')
                ->where([]);
        } else {
            $query = Warning::find()
                ->leftJoin('station', 'station.id = warning.station_id')
                ->where([]);
        }

        // permission
        $role = new Role();
        if (!$role->isAdministrator) {
            $position = $role->getPosition();
            $stationIds = Station::getByRole($position, Yii::$app->user->id);
            $condition = ['in', 'station_id', $stationIds];
            $query->where($condition);
        }

        // filter by area
        $areaId = Yii::$app->request->get('area_id');
        if ($areaId > 0) {
            $query->andWhere(['station.area_id' => $areaId]);
        }

        // filter by time points
        $getBy = Yii::$app->request->get('get_by');
        if ($getBy) {
            if ($getBy == 'today') {
                $timePoints = Convert::currentTimePoints();
            } else if ($getBy == 'week') {
                $timePoints = Convert::currentWeekTimePoints();
            } else if ($getBy == 'month') {
                $timePoints = Convert::currentMonthTimePoints();
            }
            $query->andWhere(['>=', 'warning.warning_time', $timePoints['start']]);
            $query->andWhere(['<=', 'warning.warning_time', $timePoints['end']]);

        }

        // filter by time duration
        $fromDate = Yii::$app->request->get('from_date');
        if ($fromDate) {
            $fromTime = Convert::date2Time($fromDate, 'd/m/Y');
            $query->andWhere(['>=', 'warning_time', $fromTime]);
            $parseData['fromDate'] = Convert::date2date($fromDate, 'd/m/Y', 'm/d/Y');
        }
        $toDate = Yii::$app->request->get('to_date');
        if ($toDate) {
            $toTime = Convert::date2Time($toDate, 'd/m/Y', 'end');
            $query->andWhere(['<=', 'warning_time', $toTime]);
            $parseData['toDate'] = Convert::date2date($toDate, 'd/m/Y', 'm/d/Y');
        }

        $query->orderBy('warning_time DESC');

        return [
            'query'     => $query,
            'parseData' => $parseData,
        ];
    }

    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    public function actionCreate()
    {
        $model = new Warning();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('create', [
                'model' => $model,
            ]);
        }
    }

    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    public function actionRead() {
        $id = Yii::$app->request->post('warning_id');
        if ($id > 0) {
            Yii::$app->db->createCommand()
                ->update('warning', ['read' => Warning::STATUS_READ], ['id' => $id])
                ->execute();
        }
    }

    public function actionCronLatest() {

        $soundConditionTime = 900;
        $data['html'] = '';
        $data['count'] = 0;

        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $timeLoop = $post['time_loop'];
            $from = $post['current_time'] - $timeLoop;
            $to = $post['current_time'];

            // permission
            $role = new Role();
            $condition = [];
            if (!$role->isAdministrator) {
                $position = $role->getPosition();
                $stationIds = Station::getByRole($position, Yii::$app->user->id);
                $condition[] = ['in', 'station_id', $stationIds];
            }
            $condition[] = ['>=', 'warning_time', $from];
            $condition[] = ['<=', 'warning_time', $to];

            $warnings = Warning::getWarning('warning_time DESC', 0, $condition);
            if (!empty($warnings)) {
                $data['count'] = count($warnings);
                $data['html'] = Show::warnings($warnings);
            }
        }

        print json_encode($data);
    }

    public function actionCronUnread() {
        $html = '';
        $count = 0;
        $post = Yii::$app->request->post();

        // permission
        $role = new Role();
        $condition = [];
        if (!$role->isAdministrator) {
            $position = $role->getPosition();
            $stationIds = Station::getByRole($position, Yii::$app->user->id);
            $condition[] = ['in', 'station_id', $stationIds];
        };
        $condition[] = ['=', 'read', Warning::STATUS_UNREAD];

        $warnings = Warning::getWarning('warning_time DESC', 0, $condition);
        if (!empty($warnings)) {
            $count = count($warnings);
            $html = Show::warningsTable($warnings);
        }

        $data['html'] = $html;
        $data['count'] = $count;
        print json_encode($data);
    }

    protected function findModel($id)
    {
        if (($model = Warning::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
