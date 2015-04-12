<?php

namespace app\modules\station\controllers;

use Yii;
use common\models\Station;
use common\models\Area;
use common\models\Center;
use common\models\Equipment;
use common\models\EquipmentStatus;
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
        $dataProvider = new ActiveDataProvider([
            'query' => Station::find(),
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
                $model->save();

                // get station id
                $stationId = Yii::$app->db->lastInsertID;

                // insert equipments for station
                $this->setEquipment($post['equipments'], $stationId, $post['code']);

                return $this->redirect(['index']);
            }
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
        $this->findModel($id)->delete();

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

    // find model
    protected function findModel($id)
    {
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

            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    // change left menu function
    protected function setDetailLeftMenu($id) {
        $menu = [
            ['label' => 'Thêm mới trạm', 'url' => '/station/default/create'],
            ['label' => 'Thông tin chi tiết', 'url' => '/station/default/view?id='. $id],
            ['label' => 'Cập nhật thông tin', 'url' => '/station/default/update?id='. $id],
            ['label' => 'Tham số', 'url' => '/station/default/configure?id='. $id],
            ['label' => 'Tình trạng điện', 'url' => '/station/default/electric?id='. $id],
            ['label' => 'Cảnh báo', 'url' => '/station/default/warning?id='. $id],
        ];
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

    // statistic electric status
    public function actionElectric($id) {

    }

    // statistic configure status
    public function actionConfigure($id) {

    }

    // statistic warning
    public function actionWarning($id) {

    }
}
