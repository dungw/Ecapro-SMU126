<?php

namespace frontend\modules\message;

use common\modules\Base;

class Message extends Base
{
    public $controllerNamespace = 'app\modules\message\controllers';
    public $menus = [
        ['label' => 'Thêm mới thông báo', 'url' => '/message/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
