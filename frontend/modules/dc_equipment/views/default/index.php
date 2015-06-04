<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Danh sách thiết bị tủ DC';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="dc-equipment-index">

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
            'unit_voltage',
            'unit_amperage',
            [
                'attribute' => 'active',
                'value' => function($model) {

                        return $model->getStatusLabel($model->active);
                    },
            ],

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
