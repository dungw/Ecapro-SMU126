<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\Warning */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="warning-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'station_id')->textInput() ?>

    <?= $form->field($model, 'message')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'picture')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'warning_time')->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
