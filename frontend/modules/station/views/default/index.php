<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Stations';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="station-index">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Create Station', ['create'], ['class' => 'btn btn-success']) ?>
    </p>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'code',
            'name',
            'center_id',
            'area_id',
            // 'type',
            // 'firmware',
            // 'staff_id',
            // 'power_type',
            // 'pbx_type',
            // 'transmission_type',
            // 'accu_type',
            // 'accu_capacity',
            // 'generator_type',
            // 'generator_capacity',
            // 'addition:ntext',
            // 'picture_ip',
            // 'video_ip',
            // 'latitude',
            // 'longtitude',
            // 'phone',
            // 'email:email',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>

</div>
