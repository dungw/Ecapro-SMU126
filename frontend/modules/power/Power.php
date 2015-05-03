<?php

namespace frontend\modules\power;

use common\modules\Base;

class Power extends Base
{
    public $controllerNamespace = 'app\modules\power\controllers';
    public $menus = [
        ['label' => 'Thêm mới thiết bị', 'url' => '/power/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
