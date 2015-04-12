<?php

use yii\helpers\Html;

$this->title = 'Cập nhật thông tin: ' . ' ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => 'DS Nhân viên', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Cập nhật';
?>
<div class="staff-update">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
