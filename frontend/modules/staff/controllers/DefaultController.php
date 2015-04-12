<?php

namespace app\modules\staff\controllers;

use Yii;
use common\models\Staff;
use common\models\StaffSearch;
use common\models\User;
use common\controllers\BaseController;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;


class DefaultController extends BaseController
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
        $searchModel = new StaffSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    // view action
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    // create action
    public function actionCreate()
    {
        $model = new Staff();

        // parse data to view
        $parseData['model'] = $model;

        if (Yii::$app->request->isPost) {
            $model->load(Yii::$app->request->post());
            unset($model->username);

            // validate data
            if ($model->validate()) {

                // validate username
                $username = Yii::$app->request->post('username');

                // check duplicate user
                if (User::findByUsername($username)) {
                    $parseData['errors']['username'] = 'Username này đã tồn tại';
                }

                // save
                $model->save();

                // redirect
                $this->redirect(['index']);
            }
        }

        return $this->render('create', $parseData);
    }

    // update action
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

    // delete action
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    // find model function
    protected function findModel($id)
    {
        if (($model = Staff::findOne($id)) !== null) {

            $model->user = User::findOne($model->user_id);

            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
