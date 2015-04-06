<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\Station */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="station-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'code')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'center_id')->textInput() ?>

    <?= $form->field($model, 'area_id')->textInput() ?>

    <?= $form->field($model, 'type')->textInput() ?>

    <?= $form->field($model, 'firmware')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'staff_id')->textInput() ?>

    <?= $form->field($model, 'power_type')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'pbx_type')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'transmission_type')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'accu_type')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'accu_capacity')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'generator_type')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'generator_capacity')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'addition')->textarea(['rows' => 6]) ?>

    <?= $form->field($model, 'picture_ip')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'video_ip')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'latitude')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'longtitude')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'phone')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'email')->textInput(['maxlength' => 50]) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
