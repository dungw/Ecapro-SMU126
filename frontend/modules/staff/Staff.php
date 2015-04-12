<?php

namespace frontend\modules\staff;

use common\modules\Base;

class Staff extends Base
{
    public $controllerNamespace = 'app\modules\staff\controllers';
    public $menus = [
        ['label' => 'Thêm mới nhân viên', 'url' => '/staff/default/create']
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
