<?php
namespace common\components\helpers;

class Convert {

    public static function dec2Bin($decimal, $length) {
        $binary = decbin($decimal);
        $curLength = strlen($binary);
        if ($curLength < $length) {
            for ($i=0; $i<($length-$curLength); $i++) {
                $binary = '0' . $binary;
            }
        }
        return $binary;
    }

}