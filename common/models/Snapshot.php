<?php
namespace common\models;

use \Yii;

class Snapshot
{
    //url to get content
    public $url;

    //time out duration(s)
    public $timeout = 2;

    public function init($url)
    {
        $this->url = $url;
    }

    public function getType()
    {
        return ['image/jpeg', 'image/jpg', 'image/png', 'image/bmp', 'image/gif'];
    }

    public function takes($numb)
    {
        $data = [];
        if ($numb > 0) {
            for ($i = 1; $i <= $numb; $i++) {
                $pic = $this->takeOne();
                if ($pic) {
                    $data[] = $pic;
                } else {
                    break;
                }

            }
        }

        return $data;
    }

    /**
     * @return bool|string
     */
    public function takeOne()
    {
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

        //new file name
        $file = 'alarm_' . date('s') . rand(1000, 9999999) . '.jpeg';

        //get picture from url
        $content = $this->_pull();

        //check is picture or not
        if ($this->isPicture($content['type'])) {
            //write content
            $fh = fopen($path . $file, 'w') or die('Cannot create directories');
            file_put_contents($path . $file, $content);
            $inDB = date('Y/m/d/') . $file;

            return $inDB;
        } else {
            return false;
        }
    }

    private function isPicture($type)
    {
        $listType = $this->getType();
        if (in_array($type, $listType)) {
            return true;
        } else {
            return false;
        }
    }

    private function _pull()
    {
        $curl_handle = curl_init();
        curl_setopt($curl_handle, CURLOPT_URL, $this->url);
        curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, $this->timeout);
        curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl_handle, CURLOPT_USERAGENT, 'GPIS88CE');
        $content['data'] = curl_exec($curl_handle);
        $content['type'] = curl_getinfo($curl_handle, CURLINFO_CONTENT_TYPE);
        curl_close($curl_handle);
        return $content;
    }
}


