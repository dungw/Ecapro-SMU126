<?php

use yii\helpers\Html;

$this->title = 'Cập nhật: ' . ' ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị nguồn điện', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Cập nhật';
?>
<div class="power-equipment-update">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
