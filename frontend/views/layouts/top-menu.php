<?php
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\base\Module;

// get current controller
$module = $this->context->module->id;

if (!Yii::$app->user->isGuest) {
    NavBar::begin([
        'brandLabel' => 'Dashboard',
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-inverse navbar-fixed-top',
        ],
    ]);

    $menuItems = [
        ['label' => 'Home', 'url' => ['/site/index']],
        ['label' => 'Danh mục', 'url' => ['/category/default/index'], 'active' => ($module == 'category')],
        ['label' => 'Phần mềm', 'url' => ['/software/default/index'], 'active' => ($module == 'software')],
        ['label' => 'Nhà sản xuất', 'url' => ['/manufacturer/default/index'], 'active' => ($module == 'manufacturer')],
        ['label' => 'Tính năng', 'url' => ['/feature/default/index'], 'active' => ($module == 'feature')],
    ];

    if (Yii::$app->user->isGuest) {
        $menuItems[] = ['label' => 'Login', 'url' => ['/site/login']];
    } else {
        $menuItems[] = [
            'label' => 'Logout (' . Yii::$app->user->identity->username . ')',
            'url' => ['/site/logout'],
            'linkOptions' => ['data-method' => 'post']
        ];
    }
    echo Nav::widget([
        'options' => ['class' => 'navbar-nav navbar-right'],
        'items' => $menuItems,
    ]);
    NavBar::end();
}
