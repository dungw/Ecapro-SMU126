<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\Warning */

$this->title = 'Create Warning';
$this->params['breadcrumbs'][] = ['label' => 'Warnings', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="warning-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
