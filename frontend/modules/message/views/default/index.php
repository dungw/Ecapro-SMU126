<?php

use common\models\Sensor;
use yii\helpers\Html;
use yii\grid\GridView;

$this->title = 'Danh sách thông báo';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="message-index">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            [
                'class' => 'yii\grid\SerialColumn',
                'options' => [
                    'width' => '6%',
                ],
            ],

            'name',
            [
                'attribute' => 'sensor_id',
                'value' => function($model) {
                        $sensor = Sensor::findOne($model->sensor_id);
                        return $sensor['name'];
                    },
            ],
            'message_0',
            'message_1',

            [
                'class' => 'yii\grid\ActionColumn',
                'template' => '{update} {delete}',
                'options' => [
                    'width' => '10%',
                ],
            ],
        ],
    ]); ?>

</div>
