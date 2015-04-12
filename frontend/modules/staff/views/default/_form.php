<?php
use common\components\helpers\Show;
use yii\helpers\Html;
use yii\widgets\ActiveForm;

$labels = $model->attributeLabels();
$labels['username'] = 'Tên đăng nhập';
$labels['password'] = 'Mật khẩu';
?>

<div class="staff-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'fullname')->textInput(['maxlength' => 255]) ?>

    <?= $form->field($model, 'mobile')->textInput(['maxlength' => 50]) ?>

    <?= $form->field($model, 'email')->textInput(['maxlength' => 100]) ?>

    <?= Show::input('text', $model->user, 'username', $labels, [], isset($errors) ? $errors : []) ?>

    <?= Show::input('password', $model->user, 'password', $labels, [], isset($errors) ? $errors : []) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Thêm mới' : 'Cập nhật', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
