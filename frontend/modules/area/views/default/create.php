<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\Area */

$this->title = 'Thêm mới khu vực';
$this->params['breadcrumbs'][] = ['label' => 'DS Khu vực', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="area-create">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
