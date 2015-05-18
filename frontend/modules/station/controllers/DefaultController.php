<?php

namespace app\modules\station\controllers;

use common\models\StationStatusController;
use Yii;
use common\models\Client;
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
use common\models\PowerEquipment;
use common\models\PowerStatus;
use common\controllers\FrontendController;
use common\models\StationStatusHandler;
use common\models\Warning;
use common\components\helpers\Convert;
use yii\db\Query;
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
        $query = Station::find()->select('station.*');

        // session
        $role = new Role();
        if (!$role->isAdministrator) {
            $position = $role->getPosition();
            $stationIds = Station::getByRole($position, Yii::$app->user->id);
            $condition = ['in', 'station.id', $stationIds];
            $query->where($condition);
        }

        // conditions
        $areaId = Yii::$app->request->get('area_id');
        if ($areaId > 0) {
            $query->andWhere(['area_id' => $areaId]);
        }

        // has_warning
        $hasWarning = Yii::$app->request->get('has_warning');
        if ($hasWarning) {

            $getBy = Yii::$app->request->get('get_by');
            if ($getBy == 'today') {
                $timePoints = Convert::currentTimePoints();
            } else if ($getBy == 'week') {
                $timePoints = Convert::currentWeekTimePoints();
            } else if ($getBy == 'month') {
                $timePoints = Convert::currentMonthTimePoints();
            }

            if (isset($timePoints)) {

                $subSql = new Query();
                $subSql->select('count(w.id) AS total_warning')
                    ->from('warning w')
                    ->where(['w.station_id' => 's.id'])
                    ->andWhere(['>=', 'w.warning_time', $timePoints['start']])
                    ->andWhere(['<=', 'w.warning_time', $timePoints['end']]);

                if ($hasWarning == 'yes') {

                    $query->andWhere(($subSql->createCommand()->rawSql) . ' > 0 ');

                } else if ($hasWarning == 'no') {

                    $query->andWhere(($subSql->createCommand()->rawSql) . ' <= 0 ');

                }
            }
        }

        // connect
        $connect = Yii::$app->request->get('connect');
        if ($connect) {
            if ($connect == 'yes') {
                $query->andWhere(['status' => Station::STATUS_CONNECTED]);
            } else if ($connect == 'no') {
                $query->andWhere(['status' => Station::STATUS_LOST]);
            }
        }

        // security
        $security = Yii::$app->request->get('security');
        if ($security) {
            $query->leftJoin('sensor_status', 'sensor_status.station_id = station.id');
            $query->andWhere(['sensor_id' => Sensor::ID_SECURITY]);
            if ($security == 'on') {
                $query->andWhere(['sensor_status.value' => Sensor::SECURITY_ON]);
            } else if ($security == 'off') {
                $query->andWhere(['sensor_status.value' => Sensor::SECURITY_OFF]);
            }
        }
//print $query->createCommand()->rawSql;die;
        $dataProvider = new ActiveDataProvider([
            'query' => $query->groupBy('station.id'),
        ]);

        return $this->render('index', [
            'dataProvider' => $dataProvider,
        ]);
    }

    // statistic status action
    public function actionStatus($id) {
        $model = $this->findModel($id);
        $parseData['model'] = $model;

        $parseData['dataProvider'] = new ActiveDataProvider([
            'query' => StationStatus::find()
                    ->where(['station_id' => $id])
                    ->orderBy('time_update DESC'),

        ]);

        $this->setDetailLeftMenu($id);

        return $this->render('status', $parseData);
    }

//    public function actionFind() {
//        $pathFile = Yii::getAlias('@webroot') . '/' . Yii::$app->params['json_station_file'];
//        $data = json_decode( file_get_contents($pathFile), true);
//
//        $fdata = array_filter($data, function($text) {
//            $reg = "/^".$_GET['q']."/i";	//initial case insensitive searching
//            return (bool)@preg_match($reg, $text['name']);
//        });
//        $fdata = array_values($fdata);	//reset $fdata indexs
//        $JSON = json_encode($fdata,true);
//        @header("Content-type: application/json; charset=utf-8");
//        echo $JSON;	//AJAX request
//    }

    public function actionFind() {
        $station = Station::find()->select('id,name')->all();
        $data = [];
        if (!empty($station)) {
            foreach ($station as $s) {
                $data[] = ['id' => $s->id, 'name' => $s->name];
            }
        }

        $result = array_filter($data, function($item) {
            $reg = "/^".$_GET['q']."/i";
            return (bool)@preg_match($reg, $item['name']);
        });
        $result = array_values($result);

        $JSON = json_encode($result,true);
        @header("Content-type: application/json; charset=utf-8");
        echo $JSON;
    }

    // change status parts of station
    public function actionChangeStationPart() {
        $get = Yii::$app->request->get();

        if (isset($get['part']) && $get['station_id'] > 0) {

            // find exist
            if ($get['part'] == 'equip') {
                $handler = StationStatusHandler::find()
                    ->where(['station_id' => $get['station_id'], 'updated' => StationStatusHandler::STATUS_NOT_UPDATE, 'equip_id' => $get['id'], 'type' => StationStatusHandler::TYPE_EQUIPMENT])
                    ->orderBy('created_at DESC')
                    ->one();

                // get equipment status
                $es = EquipmentStatus::findOne($get['id']);

            } else if ($get['part'] == 'security') {
                $handler = StationStatusHandler::find()
                    ->where(['station_id' => $get['station_id'], 'updated' => StationStatusHandler::STATUS_NOT_UPDATE, 'type' => StationStatusHandler::TYPE_SENSOR_SECURITY])
                    ->orderBy('created_at DESC')
                    ->one();
            }

            // model
            if (!$handler) {
                $handler = new StationStatusHandler();
            }

            // if type is equipment
            if ($get['part'] == 'equip') {
                $handler->type = StationStatusHandler::TYPE_EQUIPMENT;
                $handler->configure = $get['configure'];
                $handler->equip_id = $es['equipment_id'];

            } else if ($get['part'] == 'security') {
                $handler->type = StationStatusHandler::TYPE_SENSOR_SECURITY;
                $handler->equip_id = Sensor::ID_SECURITY;
            }

            $handler->status = $get['status'];
            $handler->station_id = $get['station_id'];
            $handler->created_at = time();
            $handler->updated = StationStatusHandler::STATUS_NOT_UPDATE;

            // validate
            if ($handler->validate()) {
                $handler->save();

                // update station
                Yii::$app->db->createCommand()
                    ->update('station', ['change_equipment_status' => 1], ['id' => $get['station_id']])
                    ->execute();

                // create message
                Yii::$app->session->setFlash('update_success', 'Đã lưu thay đổi, sau khi gửi được dữ liệu sẽ hiển thị đã gửi dữ liệu.');
            }
        }

        $this->redirect(Yii::$app->homeUrl . 'station/default/view?id='. $get['station_id']);
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

                // insert power equipments for station
                $this->setPowerEquipment($post['power_equipments'], $stationId);

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

            // get all power equipment
            $parseData['powerEquipments'] = PowerEquipment::find()->all();
            if (!empty($parseData['powerEquipments'])) {
                foreach ($parseData['powerEquipments'] as $equipment) {
                    $parseData['powerEquipmentIds'][] = $equipment->id;
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

    public function actionCronEquipmentStatus() {
        $this->enableCsrfValidation = false;
        $data = [];
        $id = Yii::$app->request->post('station_id');
        if ($id) {
            $model = $this->findModel($id);
            $data['content'] = $model->getEquipment($model->id, $model->equipment);
        }
        print json_encode($data);
    }

    // update status action
    public function actionUpdateStatus() {
        $this->enableCsrfValidation = false;

        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $data = [];
            $ids = $post['ids'];
            $idArr = explode(',', $ids);
            if (!empty($idArr)) {
                foreach ($idArr as $id) {
                    $station = Station::find()
                        ->select('status')
                        ->where(['id' => $id])
                        ->one();

                    $data['content'][$id] = $station['status'];
                }
            }

            print json_encode($data);
        }
    }

    // update action
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        // parse data
        $parseData = ['model' => $model];

        // check if not has dc status and sensor status, then create them
        if (!$model->dc_equip_status) $this->initDc($id);
        if (!$model->sensor_status) $this->initSensor($id);

        // get all equipment
        $parseData['equipments'] = Equipment::findAll(['active' => Equipment::STATUS_ACTIVE]);

        // get equipment of station
        $parseData['equipmentIds'] = $model->equipment;

        // get all power equipment
        $parseData['powerEquipments'] = PowerEquipment::find()->all();

        // get equipment of station
        $parseData['powerEquipmentIds'] = $model->power_equipment;

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

        $post = Yii::$app->request->post();

        if ($post) {

            $model->load($post);

            if ($model->validate()) {
                $model->save();

                // update equipment
                $this->setEquipment($post['equipments'], $id, $model->code);

                // update power equipment
                $this->setPowerEquipment($post['power_equipments'], $id);

                return $this->redirect(['view', 'id' => $model->id]);
            }
        }

        return $this->render('update', $parseData);
    }

    // delete action
    public function actionDelete($id)
    {
        $id = Yii::$app->request->get('id');
        if ($id > 0) {

            // delete equipment status
            DcEquipmentStatus::deleteAll(['station_id' => $id]);

            // delete sensor status
            SensorStatus::deleteAll(['station_id' => $id]);

            // delete dc status
            DcStatus::deleteAll(['station_id' => $id]);

            // delete dc equipment status
            DcEquipmentStatus::deleteAll(['station_id' => $id]);

            // delete power status
            PowerStatus::deleteAll(['station_id' => $id]);

            // delete station status
            StationStatus::deleteAll(['station_id' => $id]);

            // delete station status controller
            StationStatusController::deleteAll(['station_id' => $id]);

            // delete warning
            $warnings = Warning::findAll(['station_id' => $id]);
            if (!empty($warnings)) {
                foreach ($warnings as $w) {
                    Yii::$app->db->createCommand()
                        ->delete('warning_picture', ['warning_id' => $w['id']])
                        ->execute();
                }
            }
            Warning::deleteAll(['station_id' => $id]);

            // delete station
            Station::deleteAll(['id' => $id]);

        }

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

        // get power equipment
        $parseData['powerEquipments'] = $model->getPowerEquipment($model->id, $model->power_equipment);

        return $this->render('view', $parseData);
    }

    // find model
    protected function findModel($id)
    {
        // session
        $role = new Role();
        if (!$role->isAdministrator) {
            $position = $role->getPosition();
            $stationIds = Station::getByRole($position, Yii::$app->user->id);
            if (!empty($stationIds) && !in_array($id, $stationIds)) {
                $this->permissionDeny();
            }
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

            // get power equipment
            $powerEquipments = PowerStatus::findAll(['station_id' => $id]);
            if (!empty($powerEquipments)) {
                foreach ($powerEquipments as $equipment) {
                    $model->power_equipment[] = $equipment->item_id;
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
            $query = new Query();
            $sensorStatus = $query->select('sst.*, s.type, s.unit_type, s.name')
                ->from('sensor_status sst')
                ->leftJoin('sensor s', 's.id = sst.sensor_id')
                ->where(['sst.station_id' => $id])
                ->andWhere(['s.active' => Sensor::STATUS_ACTIVE])
                ->all();

            if (!empty($sensorStatus)) {
                foreach ($sensorStatus as $sst) {
                    $model->sensor_status[] = [
                        'type' => $sst['type'],
                        'sensor_id' => $sst['sensor_id'],
                        'name' => $sst['name'],
                        'unit' => $sst['unit_type'],
                        'value' => $sst['value'],
                        'status' => $sst['status'],
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

        // session
        $role = new Role();

        $menu = [];
        if ($role->isAdministrator || $role->isAdmin) {
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

    // set power equipment
    private function setPowerEquipment($ids, $stationId) {
        if (!empty($ids) && $stationId > 0) {
            $model = $this->findModel($stationId);

            // delete excess equipment
            $excessIds = array_diff($model->power_equipment, $ids);
            if (!empty($excessIds)) {
                foreach ($excessIds as $excessId) {
                    PowerEquipment::deleteAll(['item_id' => $excessId, 'station_id' => $stationId]);
                }
            }

            // add new equipment
            $newIds = array_diff($ids, $model->power_equipment);
            if (!empty($newIds)) {
                foreach ($newIds as $newId) {
                    $data[] = [$newId, $stationId];
                }

                Yii::$app->db->createCommand()
                    ->batchInsert('power_status', ['item_id', 'station_id'], $data)
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

    // send message to station
    public function sendMessage() {
        if (Yii::$app->request->isAjax) {
            $post = Yii::$app->request->post();
            if (isset($post['id']) && $post['id'] > 0) {
                $station = Station::findOne($post['id']);
                $ip = $station['ip'];
                $port = $station['port'];
                if ($ip != '' && $port != '') {
                    $client = new Client();
                    $init = $client->init($ip, $port);
                    if ($init) {
                        $send = $client->send($post['message']);
                        if ($send) {
                            print $client->returnMessage;
                        } else {
                            print $client->error;
                        }
                    } else {
                        print $client->error;
                    }
                }
            }
        }
        print 'failed';
    }
}
