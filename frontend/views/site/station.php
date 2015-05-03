<?php
use common\models\Area;
use common\models\Center;
use common\models\Station;
use common\components\helpers\Show;

use yii\helpers\Html;
use yii\grid\GridView;

$station = new Station();
$statusData = $station->_statusData;

?>
<script src="<?=Yii::$app->homeUrl . 'js/jquery-crontab-station.js'?>"></script>

<div class="hidden">
    <input type="hidden" id="ids" value="<?=implode(',', $dataProvider->getKeys())?>">
</div>

<div class="row">

    <div class="col-sm-12 block-station">
        <div class="panel panel-primary" id="panel-station">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <i class="glyphicon glyphicon-phone"></i><span style="margin-right: 10px;">Danh sách trạm</span>
                </h4>
            </div>
        </div>

        <?=GridView::widget([
            'dataProvider' => $dataProvider,
            'filterModel' => $searchModel,
            'summary' => false,
            'columns' => [
                [
                    'attribute' => 'code',
                    'filter' => true,
                    'options' => [
                        'width' => '10%',
                    ],
                ],
                [
                    'attribute' => 'name',
                ],
                [
                    'attribute' => 'center_id',
                    'format' => 'text',

                    'filter' => Center::_prepareDataSelect(Center::find()->all(), 'id', 'name', false),
                    'value' => function($model) {
                            $center = Center::findOne($model->center_id);
                            return $center->name;
                        },
                    'options' => [
                        'width' => '15%',
                    ],
                ],
                [
                    'attribute' => 'area_id',
                    'format' => 'text',
                    'filter' => Area::_prepareDataSelect(Area::find()->all(), 'id', 'name', false),
                    'value' => function($model) {
                            $area = Area::findOne($model->area_id);
                            return $area->name;
                        },
                    'options' => [
                        'width' => '15%',
                    ],
                ],
                [
                    'attribute' => 'status',
                    'format' => 'html',
                    'filter' => $statusData,
                    'value' => function($model) {
                            if ($model->status == Station::STATUS_CONNECTED) $html = Show::decorateString($model->getStatus($model->status), 'good');
                            if ($model->status == Station::STATUS_LOST) $html = Show::decorateString($model->getStatus($model->status), 'bad');
                            return $html;
                        },
                    'contentOptions' => function($model) {
                            return [
                                'id' => 'status-'. $model->id,
                                'class' => ($model->status == 1) ? 'connected' : 'disconnect',
                            ];
                        },
                    'options' => [
                        'width' => '10%',
                    ],
                ],
                [
                    'label' => '',
                    'format' => 'raw',
                    'value' => function($model) {
                            $stationHref = Yii::$app->homeUrl . 'station/default/view?id=' . $model->id;
                            return '<a target="_blank" href="'. $stationHref .'" class="btn btn-primary btn-xs">Chi tiết trạm</a>';
                        },
                    'options' => [
                        'width' => '12%',
                    ],
                ],
            ],
        ]);
        ?>

    </div>

</div>
