<?php

use yii\helpers\Html;

$this->title = 'Thêm mới thiết bị nguồn điện';
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị nguồn điện', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="power-equipment-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
