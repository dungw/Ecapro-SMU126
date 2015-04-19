<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\StationStatus */

$this->title = 'Create Station Status';
$this->params['breadcrumbs'][] = ['label' => 'Station Statuses', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="station-status-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
