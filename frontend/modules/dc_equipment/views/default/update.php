<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\DcEquipment */

$this->title = 'Cập nhật: ' . ' ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị tủ DC', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Cập nhật';
?>
<div class="dc-equipment-update">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
