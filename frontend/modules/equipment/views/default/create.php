<?php
use yii\helpers\Html;

$this->title = 'Thêm mới thiết bị';
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="equipment-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
