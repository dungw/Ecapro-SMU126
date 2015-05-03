<?php

use yii\helpers\Html;

$this->title = 'Thêm mới thông báo';
$this->params['breadcrumbs'][] = ['label' => 'DS Thông báo', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="message-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
        'sensors' => $sensors,
    ]) ?>

</div>
