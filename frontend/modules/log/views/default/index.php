<?php
use common\models\User;
use yii\helpers\Html;
use yii\grid\GridView;
use common\components\helpers\Log;
use common\models\LogModel;
use common\models\Station;
use common\models\Equipment;

/* @var $this yii\web\View */
/* @var $searchModel common\models\LogSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Thống kê hoạt động';
$this->params['breadcrumbs'][] = $this->title;

//get all actions
$actionList = Log::actions();
?>
<div class="log-index">

    <h4><?= Html::encode($this->title) ?></h4>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            [
                'attribute' => 'user_id',
                'value'     => function($model) {
                    $user = User::findOne($model->user_id);
                    return $user->username;
                }
            ],
            [
                'attribute' => 'action',
                'filter' => LogModel::_prepareDataSelect($actionList, 'key', 'name', false),
                'value'     => function($model) {
                    $actionList = Log::actions();
                    foreach ($actionList as $action) {
                        if ($model->action === $action['key']) return $action['name'];
                    }
                }
            ],
            [
                'attribute' => 'station_id',
                'value'     => function($model) {
                    $station = Station::findOne($model->station_id);
                    return $station->name;
                }
            ],
            [
                'attribute' => 'related_id',
                'value'     => function($model) {
                    $equip = Equipment::findOne($model->related_id);
                    return $equip ? $equip['name'] : '';
                }
            ],
            [
                'attribute' => 'time',
                'filter'    => false,
                'value'     => function($model) {
                    return $model->time > 0 ? date('d/m/Y h:i A', $model->time) : '';
                }
            ],
        ],
    ]); ?>

</div>
