<?php

namespace app\modules\power\controllers;

use common\models\Station;
use Yii;
use common\controllers\FrontendController;
use common\models\PowerEquipment;
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
            'query' => PowerEquipment::find(),
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
        $model = new PowerEquipment();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {

	        //add new equipment to all exist stations
	        $newID = Yii::$app->db->lastInsertID;

	        $stations = Station::find()->all();
	        if (!empty($stations))
	        {
		        foreach ($stations as $station)
		        {
			        var_dump($station['id']);
			        Yii::$app->db->createCommand()
				        ->insert('power_status', [
					        'station_id'    => $station['id'],
					        'item_id'       => $newID
				        ])
			            ->execute();
		        }
	        }

            return $this->redirect(['index']);
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
            return $this->redirect(['index']);
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

    protected function findModel($id)
    {
        if (($model = PowerEquipment::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
