<?php

namespace frontend\modules\center;

use common\modules\Base;

class Center extends Base
{
    public $controllerNamespace = 'app\modules\center\controllers';
    public $menus = [
        ['label' => 'Thêm mới trung tâm', 'url' => '/center/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
