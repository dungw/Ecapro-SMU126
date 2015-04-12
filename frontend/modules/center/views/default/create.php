<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\Center */

$this->title = 'Thêm mới trung tâm';
$this->params['breadcrumbs'][] = ['label' => 'DS Trung tâm', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="center-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
