<?php

namespace app\modules\warning\controllers;

use Yii;
use common\models\Warning;
use common\models\Station;
use common\controllers\FrontendController;
use common\components\helpers\Convert;
use common\components\helpers\Show;
use common\models\Observer;

use yii\data\ActiveDataProvider;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;

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

    public function actionIndex()
    {
//        for ($i = 1; $i <= 3; $i++) {
//            $string = '533db2&TR01&alarm&mat dien luoi';
//            $observer = new Observer();
//            $observer->handleRequest($string);
//        }
        $query = Warning::find()->where([]);

        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $id = $post['station_id'];
            if (isset($post['station_id']) && $post['station_id'] > 0) {
                $query->andWhere(['station_id' => $post['station_id']]);
                $parseData['station'] = Station::findOne($post['station_id']);
            }
            if (isset($post['from_date']) && trim($post['from_date']) != '') {
                $from = Convert::date2Time($post['from_date'], 'd/m/Y');
                $query->andWhere(['>=', 'warning_time', $from]);
                $parseData['fromDate'] = $post['from_date'];
            }
            if (isset($post['to_date']) && trim($post['to_date']) != '') {
                $to = Convert::date2Time($post['to_date'], 'd/m/Y', 'end');
                $query->andWhere(['<=', 'warning_time', $to]);
                $parseData['toDate'] = $post['to_date'];
            }
        }

        // permission
        $condition = isset(Yii::$app->session['station_ids']) ? ['station_id' => Yii::$app->session['station_ids']] : [];

        $dataProvider = new ActiveDataProvider([
            'query' => $query->where($condition)->orderBy('warning_time DESC'),
            'pagination' => [
                'pageSize' => Yii::$app->params['page_size'],
            ],
        ]);

        $parseData['dataProvider'] = $dataProvider;

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

    public function actionLatest() {
        $html = '';
        $count = 0;
        $this->enableCsrfValidation = false;
        $post = Yii::$app->request->post();
        if (!empty($post)) {
            $timeLoop = $post['time_loop'];
            $from = $post['current_time'] - $timeLoop;
            $to = $post['current_time'];

            // permission
            $condition = isset(Yii::$app->session['station_ids']) ? ['station_id' => Yii::$app->session['station_ids']] : [];
            $condition[] = ['>=', 'warning_time', $from];
            $condition[] = ['<=', 'warning_time', $to];

            $warnings = Warning::getWarning('warning_time DESC', 0, $condition);
            if (!empty($warnings)) {
                $count = count($warnings);
                $html = Show::warnings($warnings);
            }
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
