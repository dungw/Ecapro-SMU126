<?php

namespace app\modules\message\controllers;

use Yii;
use common\models\Message;
use common\models\Sensor;
use common\controllers\FrontendController;
use yii\data\ActiveDataProvider;
use yii\web\Controller;
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

    public function actionIndex()
    {
        $dataProvider = new ActiveDataProvider([
            'query' => Message::find(),
        ]);

        return $this->render('index', [
            'dataProvider' => $dataProvider,
        ]);
    }

    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    public function actionCreate()
    {
        $model = new Message();
        $parseData['model'] = $model;

        $parseData['sensors'] = $this->getSensor();

        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $model->load($post);

            $model->save();

            return $this->redirect(['index']);
        }

        return $this->render('create', $parseData);
    }

    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $parseData['model'] = $model;

        $parseData['sensors'] = $this->getSensor();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['index']);
        }

        return $this->render('update', $parseData);
    }

    private function getSensor() {
        $sensorCollections = Sensor::findAll(['type' => Sensor::TYPE_CONFIGURE]);
        return Sensor::_prepareDataSelect($sensorCollections, 'id', 'name');
    }

    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    protected function findModel($id)
    {
        if (($model = Message::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
