<?php

namespace app\modules\user\controllers;

use Yii;
use frontend\models\SignupForm;
use frontend\models\UpdateInfo;
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

    public function actionIndex()
    {
        $condition = isset(Yii::$app->session['user_ids']) ? ['id' => Yii::$app->session['user_ids']] : [];

        $dataProvider = new ActiveDataProvider([
            'query' => User::find()->where(['!=', 'type', SignupForm::LEVEL_ADMINISTRATOR])->andWhere($condition),
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
        $model = new SignupForm();
        $parseData['model'] = $model;

        // get user types
        $parseData['types'] = $model->_prepareDataSelect($model->_types, 'value', 'label');

        $post = Yii::$app->request->post();
        if ($post) {
            $model->load(Yii::$app->request->post());

            if ($model->validate()) {
                $model->signup();

                return $this->redirect(['index']);
            } else {
                $parseData['errors'] = $model->getErrors();
            }
        }

        return $this->render('create', $parseData);
    }

    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $parseData['model'] = $model;

        // get user types
        $parseData['types'] = $model->_prepareDataSelect($model->_types, 'value', 'label');

        $post = Yii::$app->request->post();
        if ($post) {
            $model->load(Yii::$app->request->post());

            if ($model->validate()) {
                $model->updateInfo($id);

                return $this->redirect(['index']);
            } else {
                $parseData['errors'] = $model->getErrors();
            }
        }

        return $this->render('update', $parseData);
    }

    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    protected function findModel($id)
    {
        // check belong ids
        if (isset(Yii::$app->session['user_ids']) && !in_array($id, Yii::$app->session['user_ids'])) {
            $this->permissionDeny();
        }

        if (($user = User::findOne($id)) !== null) {
            $model = new UpdateInfo();
            $model->id = $user->id;
            $model->username = $user->username;
            $model->password = $user->password_hash;
            $model->fullname = $user->fullname;
            $model->mobile = $user->mobile;
            $model->email = $user->email;
            $model->type = $user->type;
            $model->created_at = $user->created_at;
            $model->updated_at = $user->updated_at;
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
