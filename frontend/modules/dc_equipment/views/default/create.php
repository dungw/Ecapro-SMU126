<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\DcEquipment */

$this->title = 'Thêm mới thiết bị tủ DC';
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị tủ DC', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="dc-equipment-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
