<?php
namespace common\components\helpers;

class Convert {

    public static function powOf2($number) {
        $bits = array_reverse(str_split(decbin($number)));
        $output = array();
        foreach($bits as $key => $bit) {
            if($bit == 1) {
                $output[] = $key;
            }
        }
        return $output;
    }

    public static function date2Time($dateString, $format, $fromTime = 'begin') {
        $date = date_create_from_format($format, $dateString);
        $time = strtotime($date->format('m/d/Y'));
        if ($fromTime == 'end') $time += 86399;
        return $time;
    }

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

    public static function getInfoByUrl($url) {
        $data = [];
        if ($url != '') {
            if (strpos('F'.$url, 'http')) $protocol = 'http';
            if (strpos('F'.$url, 'https')) $protocol = 'https';
            $url = trim($url, $protocol.'://');
            $a = explode('/', $url);
            if (!empty($a)) {
                $b = explode(':', $a[0]);
                if (!empty($b)) {
                    $data['url'] = $protocol . '://' . trim($b[0]) . '/snapshot.cgi';
                    $data['port'] = trim($b[1]);
                }

                $c = explode('?', $a[1]);
                if (!empty($c)) {
                    $d = explode('&', $c[1]);
                    if (!empty($d)) {
                        foreach ($d as $e) {
                            $f = explode('=', $e);
                            if (strpos('F'.$e, 'user')) {
                                $data['username'] = $f[1];
                            }
                            if (strpos('F'.$e, 'pwd')) {
                                $data['password'] = $f[1];
                            }
                        }
                    }
                }
            }
        }
        return $data;
    }
}