<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị nguồn điện', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="power-equipment-view">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'name',
        ],
    ]) ?>

</div>
