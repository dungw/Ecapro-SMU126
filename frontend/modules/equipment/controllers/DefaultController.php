<?php

namespace app\modules\equipment\controllers;

use Yii;
use common\models\Equipment;
use common\controllers\BaseController;
use yii\data\ActiveDataProvider;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

class DefaultController extends BaseController
{
    public $enableCsrfValidation = false;

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
        $parseData['ids'] = '';
        $parseData['equipments'] = Equipment::findAll(['active' => Equipment::STATUS_ACTIVE]);
        if (!empty($parseData['equipments'])) {
            foreach ($parseData['equipments'] as $e) {
                $parseData['ids'] .= ',' . $e->id;
            }
        }

        $post = Yii::$app->request->post();

        if ($post && $post['ids'] != '') {
            $sort = $post['sort'];
            $ids = explode(',', trim($post['ids'], ','));
            foreach ($ids as $id) {
                $sql = 'UPDATE equipment SET sort = '. $sort[$id] .' WHERE id = '. $id;
                Yii::$app->db->createCommand($sql)->execute();
            }

            $this->redirect(['index']);
        }

        return $this->render('index', $parseData);
    }

    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    public function actionCreate()
    {
        $model = new Equipment();

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

    protected function findModel($id)
    {
        if (($model = Equipment::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
