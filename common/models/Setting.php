<?php
/**
 * Created by PhpStorm.
 * User: JFog
 * Date: 6/18/15
 * Time: 1:05 AM
 */

namespace common\models;

use yii\db\ActiveRecord;
use yii\db\Query;
use common\models\User;
use frontend\models\UpdateInfo;

class Setting extends ActiveRecord
{
    const STATUS_ACTIVE = 1;

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'settings';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'server_ip'     => 'IP Server',
            'server_port'   => 'Port Server',
        ];
    }

    public function setServerIP($ip)
    {
        $this->server_ip = $ip;
    }

    public function setServerPort($port)
    {
        $this->server_port = $port;
    }

    public function _getRoot()
    {
        $root = User::findOne(['type' => User::TYPE_ROOT]);
        if ($root) {
            return $root;
        }
        return null;
    }

    public static function getSetting()
    {
        $setting = Setting::find()
            ->where(['active' => self::STATUS_ACTIVE])
            ->one();
        return $setting;
    }
}