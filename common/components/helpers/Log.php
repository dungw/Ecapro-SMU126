<?php namespace common\components\helpers;
/**
 * Created by PhpStorm.
 * User: JFog
 * Date: 10/25/2015
 * Time: 10:45 AM
 */

use common\models\LogModel as Model;
use yii\db\Query;

class Log
{

    const ACTION_LOGIN = 'login';

    const ACTION_CREATE_STATION = 'create-station';
    const ACTION_VIEW_STATION = 'view-station';
    const ACTION_UPDATE_STATION = 'update-station';
    const ACTION_DELETE_STATION = 'delete-station';

    const ACTION_TURNON_SECURITY = 'turnon-security';
    const ACTION_TURNOFF_SECURITY = 'turnoff-security';

    const ACTION_TURNON_EQUIPMENT = 'turnon-equipment';
    const ACTION_TURNOFF_EQUIPMENT = 'turnoff-equipment';
    const ACTION_AUTOMATIC_EQUIPMENT = 'auto-equipment';

    public static function actions()
    {
        return [
            ['key' => self::ACTION_LOGIN, 'name'  => 'Đăng nhập'],
            ['key' => self::ACTION_CREATE_STATION, 'name'  => 'Thêm trạm'],
            ['key' => self::ACTION_VIEW_STATION, 'name'  => 'Xem chi tiết trạm'],
            ['key' => self::ACTION_UPDATE_STATION, 'name'  => 'Cập nhật trạm'],
            ['key' => self::ACTION_DELETE_STATION, 'name'  => 'Xóa trạm'],
            ['key' => self::ACTION_TURNON_SECURITY, 'name'  => 'Bật báo động'],
            ['key' => self::ACTION_TURNOFF_SECURITY, 'name'  => 'Tắt báo động'],
            ['key' => self::ACTION_TURNON_EQUIPMENT, 'name'  => 'Bật thiết bị'],
            ['key' => self::ACTION_TURNOFF_EQUIPMENT, 'name'  => 'Tắt thiết bị'],
            ['key' => self::ACTION_AUTOMATIC_EQUIPMENT, 'name'  => 'Chuyển chế độ tự động'],
        ];
    }

    public static function logAction($user, $action)
    {
        if ($action !== '' && $user > 0) {
            $parameters = [
                'Log'   => [
                    'action'    => $action,
                    'user_id'   => $user,
                    'time'      => time(),
                ]
            ];
            if (self::beforeLog($action)) self::insertLog($parameters);
        }
    }

    public static function logControl($user, $action, $station, $related = 0)
    {
        $related = intval($related);
        if ($action !== '' && $user > 0 && $station > 0) {
            $parameters = [
                'Log'   => [
                    'action'    => $action,
                    'user_id'   => $user,
                    'time'      => time(),
                    'related_id'    => $related,
                    'station_id'    => $station,
                ]
            ];

            if (self::beforeLog($action)) self::insertLog($parameters);
        }
    }

    /***************** Protected functions *****************/
    protected function beforeLog($action)
    {
        //check if has view action in time 1 hour ago, don't write log
        if ($action === self::ACTION_VIEW_STATION) {

            //check the last one
            $query = new Query();
            $query->select('id')
                ->from('log')
                ->where(['and', ['action' => self::ACTION_VIEW_STATION], ['>=', 'time', time()-3600]]);

            if ($query->one()) return false;
        }

        return true;
    }

    protected function insertLog($parameters)
    {
        $model = new Model();
        $model->load($parameters);
        $model->save(true);
    }
}