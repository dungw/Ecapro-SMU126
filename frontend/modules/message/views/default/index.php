<?php

use yii\helpers\Html;
use yii\grid\GridView;

$this->title = 'Danh sách thông báo';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="message-index">

    <h4><?= Html::encode($this->title) ?></h4>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'id',
            'name',
            'sort',
            'message_0',
            'message_1',
            // 'active',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>

</div>
