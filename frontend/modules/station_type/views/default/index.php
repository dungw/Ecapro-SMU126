<?php

use yii\helpers\Html;
use yii\grid\GridView;
use common\components\helpers\Show;

/* @var $this yii\web\View */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'DS Loại trạm';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="station-type-index">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            [
                'class' => 'yii\grid\SerialColumn',
                'options' => [
                    'width' => '10%',
                ],
            ],

            'name',
            [
                'attribute' => 'active',
                'format' => 'html',
                'options' => [
                    'width' => '15%',
                ],
                'value' => function($model) {
                        $color = $model->isActive() ? 'active' : 'inactive';
                        return Show::decorateString($model->getActive(), $color);
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
