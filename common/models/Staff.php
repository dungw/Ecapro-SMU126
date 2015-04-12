<?php

namespace common\models;

use Yii;
use common\models\Base;

class Staff extends Base
{
    public $user;

    // get table name
    public static function tableName()
    {
        return 'staff';
    }

    // get rule table
    public function rules()
    {
        return [
            [['fullname'], 'required'],
            [['user_id'], 'integer'],
            [['fullname'], 'string', 'max' => 255],
            [['mobile'], 'string', 'max' => 50],
            [['email'], 'string', 'max' => 100]
        ];
    }

    // get attribute label
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fullname' => 'Họ tên',
            'mobile' => 'Số điện thoại',
            'email' => 'Email',
            'user_id' => 'ID đăng nhập',
        ];
    }
}
