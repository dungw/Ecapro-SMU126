<?php

use yii\helpers\Html;

$this->title = 'Cập nhật thông báo: ' . ' ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Thông báo', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Cập nhật';
?>
<div class="message-update">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
