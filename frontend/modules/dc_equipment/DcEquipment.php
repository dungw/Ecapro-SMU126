<?php

namespace frontend\modules\dc_equipment;

use common\modules\Base;

class DcEquipment extends Base
{
    public $controllerNamespace = 'frontend\modules\dc_equipment\controllers';

    public $menus = [
        ['label' => 'Thêm mới thiết bị tủ DC', 'url' => '/dc_equipment/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
