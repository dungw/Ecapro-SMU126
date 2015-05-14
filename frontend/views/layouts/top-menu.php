<?php
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\base\Module;
use common\models\Role;

// get current controller
$module = $this->context->module->id;

if (!Yii::$app->user->isGuest) {
    NavBar::begin([
        'brandLabel' => Yii::$app->params['brandName'],
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-inverse navbar-fixed-top',
        ],
    ]);

    $menuItems = [
        ['label' => 'Home', 'url' => ['/site/index']],
        ['label' => 'Quản lý trạm', 'url' => ['/station/default/index'], 'active' => ($module == 'station')],
    ];

    // statistic menus
    $menuItems[] = [
        'label' => 'Thống kê',
        'items' => [
            ['label' => 'Thống kê trạm', 'url' => ['/statistic/station/index'], 'active' => ($module == 'statistic')],
            ['label' => 'Thống kê cảnh báo', 'url' => ['/statistic/warning/index'], 'active' => ($module == 'statistic')],
        ]
    ];

    // add by position
    if (Yii::$app->session['user_position'] == Role::POSITION_ADMINISTRATOR) {
        $menuItems[] = [
            'label' => 'Cài đặt',
            'items' => [
                ['label' => 'Trung tâm', 'url' => ['/center/default/index'], 'active' => ($module == 'center')],
                ['label' => 'Khu vực', 'url' => ['/area/default/index'], 'active' => ($module == 'area')],
                ['label' => 'Thiết bị', 'url' => ['/equipment/default/index'], 'active' => ($module == 'equipment')],
                ['label' => 'Thiết bị nguồn điện', 'url' => ['/power/default/index'], 'active' => ($module == 'power')],
                ['label' => 'Thông báo', 'url' => ['/message/default/index'], 'active' => ($module == 'message')],
                ['label' => 'Người dùng', 'url' => ['/user/default/index'], 'active' => ($module == 'user')],
            ]
        ];
    }
    else if (Yii::$app->session['user_position'] == Role::POSITION_ADMIN) {
        $menuItems[] = [
            'label' => 'Cài đặt',
            'items' => [
                ['label' => 'Người dùng', 'url' => ['/user/default/index'], 'active' => ($module == 'user')],
            ]
        ];
    }

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
