<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Warning */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Warnings', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="warning-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'station_id',
            'message',
            'picture',
            'warning_time:datetime',
        ],
    ]) ?>

</div>
