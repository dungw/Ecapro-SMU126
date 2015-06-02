<?php

use common\components\helpers\Show;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\StationType */
/* @var $form yii\widgets\ActiveForm */

$attributeLabels = $model->attributeLabels();
?>

<div class="station-type-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => 255]) ?>

    <?= Show::activeDropDownList($model, 'active', $attributeLabels, $model->optionsActive()) ?>

    <?= Show::submitButton($model) ?>

    <?php ActiveForm::end(); ?>

</div>
