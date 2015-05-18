<?php
namespace common\models;

use \Yii;

class Snapshot {

    public $url;

    public function init($url) {
        $this->url = $url;
    }

    public function takes($numb) {
        $data = [];
        if ($numb > 0) {
            for ($i=1; $i<=$numb; $i++) {
                $pic = $this->takeOne();
                if ($pic) {
                    $data[] = $this->takeOne();
                } else {
                    break;
                }
            }
        }

        return $data;
    }

    public function takeOne() {
        $path = Yii::getAlias('@frontend') . '/web/uploads/';

        // create directories by time
        if (!is_dir($path . date('Y'))) {
            mkdir($path . date('Y'));
        }
        $path .= date('Y') . '/';
        if (!is_dir($path . date('m'))) {
            mkdir($path . date('m'));
        }
        $path .= date('m') . '/';
        if (!is_dir($path . date('d'))) {
            mkdir($path . date('d'));
        }
        $path .= date('d') . '/';

        // create file name
        $file = 'alarm_' . date('s') . rand(1000, 9999) . '.jpg';

        // open new file
        $fh = fopen($path . $file, 'w') or die('Cannot create directories');
        $content = file_get_contents($this->url);
        if ($content) {
            file_put_contents($path . $file, $content);
        } else {
            return false;
        }

        $infoSave = date('Y/m/d/') . $file;

        return $infoSave;
    }
}


