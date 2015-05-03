<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Equipment */

$this->title = 'Cập nhật: ' . ' ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Cập nhật';
?>
<div class="equipment-update">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
