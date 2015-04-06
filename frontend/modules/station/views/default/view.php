<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Station */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Stations', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="station-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'code',
            'name',
            'center_id',
            'area_id',
            'type',
            'firmware',
            'staff_id',
            'power_type',
            'pbx_type',
            'transmission_type',
            'accu_type',
            'accu_capacity',
            'generator_type',
            'generator_capacity',
            'addition:ntext',
            'picture_ip',
            'video_ip',
            'latitude',
            'longtitude',
            'phone',
            'email:email',
        ],
    ]) ?>

</div>
