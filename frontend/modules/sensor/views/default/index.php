<?php

use yii\helpers\Html;
use yii\grid\GridView;
use common\components\helpers\Show;

/* @var $this yii\web\View */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Danh sách cảm biến';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sensor-index">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            [
                'class' => 'yii\grid\SerialColumn',
                'options' => [
                    'width' => '6%'
                ]
            ],

            'name',
            [
                'attribute' => 'binary_pos',
                'options' => [
                    'width' => '10%',
                ],
            ],
            [
                'attribute' => 'active',
                'format' => 'html',
                'value' => function($model) {
                        $color = $model->isActive() ? 'active' : 'inactive';
                        return Show::decorateString($model->getActive(), $color);
                    },
                'options' => [
                    'width' => '15%',
                ],
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
