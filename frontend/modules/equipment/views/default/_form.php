<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use common\components\helpers\Show;
?>

<div class="equipment-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => 255]) ?>

    <?= ($model->isNewRecord) ? '' : $form->field($model, 'binary_pos')->textInput(['maxlength' => 255]) ?>

    <?= Show::submitButton($model) ?>

    <?php ActiveForm::end(); ?>

</div>
