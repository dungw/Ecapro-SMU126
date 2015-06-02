<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\Sensor */

$this->title = 'Thêm mới cảm biến';
$this->params['breadcrumbs'][] = ['label' => 'DS Cảm biến', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="sensor-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
