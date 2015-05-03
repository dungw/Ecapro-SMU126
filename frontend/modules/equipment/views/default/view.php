<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Equipment */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Thiết bị', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="equipment-view">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            'name',
            'active',
        ],
    ]) ?>

</div>
