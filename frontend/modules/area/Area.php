<?php

namespace frontend\modules\area;

use common\modules\Base;

class Area extends Base
{
    public $controllerNamespace = 'app\modules\area\controllers';
    public $menus = [
        ['label' => 'Thêm mới tỉnh thành', 'url' => '/area/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
