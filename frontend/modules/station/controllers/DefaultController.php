<?php

namespace app\modules\station\controllers;

use Yii;
use common\models\Station;
use common\models\Area;
use common\models\Center;
use common\models\Equipment;
use common\models\EquipmentStatus;
use common\models\DcStatus;
use common\models\DcEquipment;
use common\models\DcEquipmentStatus;
use common\models\Sensor;
use common\models\SensorStatus;
use common\models\StationStatus;
use common\models\Role;
use common\models\User;
use common\controllers\FrontendController;

use yii\data\ActiveDataProvider;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

class DefaultController extends FrontendController
{
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

    // index action
    public function actionIndex()
    {
        $condition = isset(Yii::$app->session['station_ids']) ? ['id' => Yii::$app->session['station_ids']] : [];

        $dataProvider = new ActiveDataProvider([
            'query' => Station::find()->where($condition),
        ]);

        return $this->render('index', [
            'dataProvider' => $dataProvider,
        ]);
    }

    // create action
    public function actionCreate()
    {
        $model = new Station();

        $post = Yii::$app->request->post();
        if ($post) {
            $model->load($post);

            if ($model->validate()) {

                // created by logged in user
                $model->user_id = Yii::$app->user->id;
                $model->save();

                // get station id
                $stationId = Yii::$app->db->lastInsertID;

                // initial dc
                $this->initDc($stationId);

                // insert equipments for station
                $this->setEquipment($post['equipments'], $stationId, $model->code);

                // initial sensors
                $this->initSensor($stationId);
            }

            return $this->redirect(['index']);
        } else {

            // parse data
            $parseData = ['model' => $model];

            // get all equipment
            $parseData['equipments'] = Equipment::findAll(['active' => Equipment::STATUS_ACTIVE]);
            if (!empty($parseData['equipments'])) {
                foreach ($parseData['equipments'] as $equipment) {
                    $parseData['equipmentIds'][] = $equipment->id;
                }
            }

            // get area
            $areaCollections = Area::find()->all();
            $parseData['areas'] = Area::_prepareDataSelect($areaCollections, 'id', 'name');

            // get center
            $centerCollections = Center::find()->all();
            $parseData['centers'] = Center::_prepareDataSelect($centerCollections, 'id', 'name');

            // get station types
            $parseData['types'] = Station::_prepareDataSelect(Station::$types, 'type', 'name');

            return $this->render('create', $parseData);
        }
    }

    // update action
    public function actionUpdate($id)
    {

        $model = $this->findModel($id);

        $post = Yii::$app->request->post();

        if ($post) {

            $model->load($post);

            if ($model->validate()) {
                $model->save();

                // update equipment
                $this->setEquipment($post['equipments'], $id, $model->code);
            }

            return $this->redirect(['view', 'id' => $model->id]);
        } else {

            // parse data
            $parseData = ['model' => $model];

            // get all equipment
            $parseData['equipments'] = Equipment::findAll(['active' => Equipment::STATUS_ACTIVE]);

            // get equipment of station
            $parseData['equipmentIds'] = $model->equipment;

            // get area
            $areaCollections = Area::find()->all();
            $parseData['areas'] = Area::_prepareDataSelect($areaCollections, 'id', 'name');

            // get center
            $centerCollections = Center::find()->all();
            $parseData['centers'] = Center::_prepareDataSelect($centerCollections, 'id', 'name');

            // get station types
            $parseData['types'] = Station::_prepareDataSelect(Station::$types, 'type', 'name');

            // change left menu
            $this->setDetailLeftMenu($id);

            return $this->render('update', $parseData);
        }
    }

    // delete action
    public function actionDelete($id)
    {
        return $this->redirect(['index']);
    }

    // detail action
    public function actionView($id)
    {
        $model = $this->findModel($id);

        // parse data
        $parseData = ['model'=>$model];

        // set left menu
        $this->setDetailLeftMenu($id);

        // get equipment
        $parseData['equipments'] = $model->getEquipment($model->id, $model->equipment);

        return $this->render('view', $parseData);
    }

    // statistic status action
    public function actionStatus($id) {

        $parseData['model'] = $this->findModel($id);

        $parseData['status'] = StationStatus::findAll(['station_id' => $id]);

        $this->setDetailLeftMenu($id);

        return $this->render('status', $parseData);
    }

    // find model
    protected function findModel($id)
    {
        // check belong ids
        if (isset(Yii::$app->session['station_ids']) && !in_array($id, Yii::$app->session['station_ids'])) {
            $this->permissionDeny();
        }

        if (($model = Station::findOne($id)) !== null) {

            // find area & center
            $model->area = Area::findOne($model->area_id);
            $model->center = Center::findOne($model->center_id);

            // get equipment
            $equipments = EquipmentStatus::findAll(['station_id' => $id]);
            if (!empty($equipments)) {
                foreach ($equipments as $equipment) {
                    $model->equipment[] = $equipment->equipment_id;
                }
            }

            // get dc
            $model->dc_status = DcStatus::findOne(['station_id' => $id]);
            $dcEquips = DcEquipmentStatus::findAll(['station_id' => $id]);
            if (!empty($dcEquips)) {
                foreach ($dcEquips as $dcEquip) {
                    $equip = DcEquipment::findOne(['id' => $dcEquip->equipment_id]);

                    $model->dc_equip_status[] = [
                        'equipment_id' => $dcEquip->equipment_id,
                        'name' => $equip->name,
                        'amperage' => $dcEquip->amperage,
                        'voltage' => $dcEquip->voltage,
                        'temperature' => $dcEquip->temperature,
                        'status' => $dcEquip->status,
                    ];
                }
            }

            // get sensor status
            $sensorStatus = SensorStatus::findAll(['station_id' => $id]);
            if (!empty($sensorStatus)) {
                foreach ($sensorStatus as $sensorStatus) {
                    $sensor = Sensor::findOne(['id' => $sensorStatus->sensor_id]);

                    $model->sensor_status[] = [
                        'sensor_id' => $sensorStatus->sensor_id,
                        'name' => $sensor->name,
                        'unit' => $sensor->unit_type,
                        'value' => $sensorStatus->value,
                        'status' => $sensorStatus->status,
                    ];
                }
            }

            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    // change left menu function
    protected function setDetailLeftMenu($id) {
        $menu = [];
        if (Yii::$app->session['user_position'] == Role::POSITION_ADMINISTRATOR || Yii::$app->session['user_position'] == Role::POSITION_ADMIN) {
            $menu[] = ['label' => 'Thêm mới trạm', 'url' => '/station/default/create'];
            $menu[] = ['label' => 'Cập nhật thông tin', 'url' => '/station/default/update?id='. $id];
        }
        $menu[] = ['label' => 'Thông tin chi tiết', 'url' => '/station/default/view?id='. $id];
        $menu[] = ['label' => 'Thống kê trạng thái', 'url' => '/station/default/status?id='. $id];

        $this->module->menus = $menu;
    }

    // add equipment to station
    private function setEquipment($equipmentIds, $stationId, $stationCode) {

        if (!empty($equipmentIds) && $stationId > 0 && $stationCode != '') {
            $model = $this->findModel($stationId);

            // delete excess equipment
            $excessIds = array_diff($model->equipment, $equipmentIds);
            if (!empty($excessIds)) {
                foreach ($excessIds as $excessId) {
                    EquipmentStatus::deleteAll(['equipment_id' => $excessId, 'station_id' => $stationId]);
                }
            }

            // add new equipment
            $newIds = array_diff($equipmentIds, $model->equipment);
            if (!empty($newIds)) {
                foreach ($newIds as $newId) {
                    $data[] = [$newId, $stationId, $stationCode];
                }

                Yii::$app->db->createCommand()
                    ->batchInsert('equipment_status', ['equipment_id', 'station_id', 'station_code'], $data)
                    ->execute();
            }
        }
    }

    // initial dc
    public function initDc($stationId) {
        if ($stationId > 0) {

            // insert dc status
            $dcModel = new DcStatus();
            $dcModel->station_id = $stationId;
            $dcModel->voltage = 0;
            $dcModel->save();

            // insert dc equipment status
            $dcEquips = DcEquipment::find()->all();

            if (!empty($dcEquips)) {
                foreach ($dcEquips as $dcEquip) {
                    $dataEquipStatus[] = [$stationId, $dcEquip->id];
                }

                Yii::$app->db->createCommand()
                    ->batchInsert('dc_equipment_status', ['station_id', 'equipment_id'], $dataEquipStatus)
                    ->execute();
            }
        }
    }

    // initial sensor status
    public function initSensor($stationId) {
        if ($stationId > 0) {
            $sensors = Sensor::find()->all();
            if (!empty($sensors)) {
                foreach ($sensors as $sensor) {
                    $data[] = [$sensor->id, $stationId];
                }

                Yii::$app->db->createCommand()
                    ->batchInsert('sensor_status', ['sensor_id', 'station_id'], $data)
                    ->execute();
            }
        }
    }

}
