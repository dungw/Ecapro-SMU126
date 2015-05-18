<?php

use yii\helpers\Html;
use yii\grid\GridView;

$this->title = 'Danh sách thiết bị nguồn điện';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="power-equipment-index">

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
                'class' => 'yii\grid\ActionColumn',
                'template' => '{update} {delete}',
                'options' => [
                    'width' => '15%',
                ],
            ],
        ],
    ]); ?>

</div>
