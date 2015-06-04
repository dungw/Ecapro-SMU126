<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use common\components\helpers\Show;

/* @var $this yii\web\View */
/* @var $model common\models\DcEquipment */
/* @var $form yii\widgets\ActiveForm */

$attributeLabels = $model->attributeLabels();
?>

<div class="dc-equipment-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'unit_voltage')->textInput(['maxlength' => 10]) ?>

    <?= $form->field($model, 'unit_amperage')->textInput(['maxlength' => 10]) ?>

    <?= Show::activeDropDownList($model, 'active', $attributeLabels, $model->optionStatus()) ?>

    <?= Show::submitButton($model) ?>

    <?php ActiveForm::end(); ?>

</div>
