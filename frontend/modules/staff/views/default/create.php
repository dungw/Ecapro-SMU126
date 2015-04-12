<?php
use yii\helpers\Html;

$this->title = 'Thêm mới nhân viên';
$this->params['breadcrumbs'][] = ['label' => 'DS Nhân viên', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="staff-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
