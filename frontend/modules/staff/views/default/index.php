<?php

use yii\helpers\Html;
use yii\grid\GridView;

$this->title = 'Danh sách nhân viên trực';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="staff-index">

    <h4><?= Html::encode($this->title) ?></h4>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
//        'filterModel' => $searchModel,
        'columns' => [
            [
                'class' => 'yii\grid\SerialColumn',
                'options' => [
                    'width' => '5%',
                ]
            ],
            [
                'attribute' => 'id',
                'options' => [
                    'width' => '7%',
                ]
            ],
            'fullname',
            'mobile',
            'email:email',
            'user_id',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>

</div>
