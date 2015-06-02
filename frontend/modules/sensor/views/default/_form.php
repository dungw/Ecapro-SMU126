<?php

use yii\widgets\ActiveForm;

use common\components\helpers\Show;

/* @var $this yii\web\View */
/* @var $model common\models\Sensor */
/* @var $form yii\widgets\ActiveForm */

$attributeLabels = $model->attributeLabels();
?>

<div class="sensor-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'binary_pos')->textInput() ?>

    <?= Show::activeDropDownList($model, 'active', $attributeLabels, $model->optionsActive()) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Thêm mới' : 'Cập nhật', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
