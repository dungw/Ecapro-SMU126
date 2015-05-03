<?php

namespace frontend\modules\equipment;

use common\modules\Base;

class Equipment extends Base
{
    public $controllerNamespace = 'app\modules\equipment\controllers';
    public $menus = [
        ['label' => 'Thêm mới thiết bị', 'url' => '/equipment/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
