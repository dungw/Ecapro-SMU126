<?php

namespace frontend\modules\station_type;

class StationType extends \yii\base\Module
{
    public $controllerNamespace = 'frontend\modules\station_type\controllers';

    public $menus = [
        ['label' => 'Thêm mới loại trạm', 'url' => '/station_type/default/create'],
    ];

    public function init()
    {
        parent::init();

        // custom initialization code goes here
    }
}
