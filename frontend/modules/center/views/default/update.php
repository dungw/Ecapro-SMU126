<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Center */

$this->title = 'Cập nhật trung tâm: ' . ' ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Trung tâm', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Cập nhật';
?>
<div class="center-update">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
