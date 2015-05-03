<?php
$this->title = Yii::$app->params['brandName'] . ' ' . Yii::$app->params['projectName'];
?>

<div class="site-index">

    <div class="body-content">

        <!-- latest warning -->
        <?= $this->render('warning', ['warnings' => $warnings]) ?>

        <!-- stations -->
        <?= $this->render('station', ['dataProvider' => $stationProvider, 'searchModel' => $searchModel]) ?>

        <!-- station locator -->
        <?= $this->render('map', []) ?>

    </div>

</div>
