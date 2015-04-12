<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use common\components\helpers\Show;

$attributeLabels = $model->attributeLabels();
?>

<div class="station-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'code')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => 255]) ?>

    <?= Show::activeDropDownList($model, 'center_id', $attributeLabels, $centers, ['class' => 'form-select'], $errors) ?>

    <?= Show::activeDropDownList($model, 'area_id', $attributeLabels, $areas, ['class' => 'form-select'], $errors) ?>

    <?= Show::activeDropDownList($model, 'type', $attributeLabels, $types, ['class' => 'form-select'], $errors) ?>

    <?= Show::multiSelect('equipments', $equipmentIds, $equipments, 'id', 'name', $attributeLabels) ?>

    <?= $form->field($model, 'staff_id')->textInput() ?>

    <?= $form->field($model, 'firmware')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'picture_ip')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'video_ip')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'latitude')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'longtitude')->textInput(['maxlength' => 20]) ?>

    <?= $form->field($model, 'phone')->textInput(['maxlength' => 100]) ?>

    <?= $form->field($model, 'email')->textInput(['maxlength' => 50]) ?>

    <?= $form->field($model, 'addition')->textarea(['rows' => 6]) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Thêm mới' : 'Cập nhật', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
