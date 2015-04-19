<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\StationStatus */

$this->title = 'Update Station Status: ' . ' ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'Station Statuses', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="station-status-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
