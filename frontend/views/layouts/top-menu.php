<div class="top-header">

</div>

<?php
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\base\Module;
use common\models\Role;

// get role
$role = new Role();

// get current controller
$module = $this->context->module->id;
$controller = $this->context->id;
$action = $this->context->action->id;

if (!Yii::$app->user->isGuest) {
    NavBar::begin([
        'brandLabel' => "<img src='/images/logo.png'>",
        'brandUrl' => Yii::$app->homeUrl,
        'options' => [
            'class' => 'navbar-inverse navbar-fixed-top',
        ],
    ]);

    $menuItems = [
        ['label' => 'Home', 'url' => ['/site/index']],
        ['label' => 'Quản lý trạm', 'url' => ['/station/default/index'], 'active' => ($module == 'station')],
        ['label' => 'Cảnh báo', 'url' => ['/warning/default/index'], 'active' => ($module == 'warning')],
    ];

    // statistic menus
    $menuItems[] = [
        'label' => 'Thống kê',
        'items' => [
            ['label' => 'Thống kê trạm', 'url' => ['/statistic/station/index'], 'active' => ($module == 'statistic' && $controller == 'station')],
            ['label' => 'Thống kê cảnh báo', 'url' => ['/statistic/warning/index'], 'active' => ($module == 'statistic' && $controller == 'warning')],
            ['label' => 'Thống kê hoạt động', 'url' => ['/log/default/index'], 'active' => ($module == 'log')],
        ]
    ];

    // add by position
    if ($role->isAdministrator) {
        $menuItems[] = [
            'label' => 'Cài đặt',
            'items' => [
                ['label' => 'Trung tâm', 'url' => ['/center/default/index'], 'active' => ($module == 'center')],
                ['label' => 'Tỉnh thành', 'url' => ['/area/default/index'], 'active' => ($module == 'area')],
                ['label' => 'Thiết bị', 'url' => ['/equipment/default/index'], 'active' => ($module == 'equipment')],
                ['label' => 'Thiết bị nguồn điện', 'url' => ['/power/default/index'], 'active' => ($module == 'power')],
                ['label' => 'Thiết bị tủ DC', 'url' => ['/dc_equipment/default/index'], 'active' => ($module == 'dc_equipment')],
                ['label' => 'Thông báo', 'url' => ['/message/default/index'], 'active' => ($module == 'message')],
                ['label' => 'Cảm biến', 'url' => ['/sensor/default/index'], 'active' => ($module == 'sensor')],
                ['label' => 'Loại trạm', 'url' => ['/station_type/default/index'], 'active' => ($module == 'station_type')],
                ['label' => 'Người dùng', 'url' => ['/user/default/index'], 'active' => ($module == 'user')],
                ['label' => 'Cài đặt chung', 'url' => ['/site/setting'], 'active' => ($controller === 'site' && $action == 'setting')],
            ]
        ];
    }
    else if ($role->isAdmin) {
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
?>
<div id="latest-warning-block"></div>
