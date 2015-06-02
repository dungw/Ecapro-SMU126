<?php

namespace frontend\modules\sensor;

use common\modules\Base;

class Sensor extends Base
{
    public $controllerNamespace = 'frontend\modules\sensor\controllers';

    public $menus = [
        ['label' => 'Thêm mới cảm biến', 'url' => '/sensor/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
