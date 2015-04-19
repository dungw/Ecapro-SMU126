<?php
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\base\Module;

// get current controller
$module = $this->context->module->id;

if (!Yii::$app->user->isGuest) {
    NavBar::begin([
        'brandLabel' => 'Ecapro',
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-inverse navbar-fixed-top',
        ],
    ]);

    $menuItems = [
        ['label' => 'Home', 'url' => ['/site/index']],
        ['label' => 'Quản lý trạm', 'url' => ['/station/default/index'], 'active' => ($module == 'station')],
        [
            'label' => 'Cài đặt',
            'items' => [
                ['label' => 'Trung tâm', 'url' => ['/center/default/index'], 'active' => ($module == 'center')],
                ['label' => 'Khu vực', 'url' => ['/area/default/index'], 'active' => ($module == 'area')],
                ['label' => 'Thiết bị', 'url' => ['/equipment/default/index'], 'active' => ($module == 'equipment')],
                ['label' => 'Thông báo', 'url' => ['/message/default/index'], 'active' => ($module == 'message')],
                ['label' => 'Nhân viên trực', 'url' => ['/staff/default/index'], 'active' => ($module == 'staff')],
            ]
        ],
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
