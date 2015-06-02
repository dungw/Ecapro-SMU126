<?php

use yii\helpers\Html;
use common\models\Sensor;

$sensor = Sensor::findOne($model->sensor_id);

$this->title = 'Cập nhật thông báo: ' . ' ' . $sensor['name'];
$this->params['breadcrumbs'][] = ['label' => 'DS Thông báo', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $sensor['name'], 'url' => ['view', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Cập nhật';
?>
<div class="message-update">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
        'sensors' => $sensors,
    ]) ?>

</div>
