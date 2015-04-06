<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "staff".
 *
 * @property integer $id
 * @property string $fullname
 * @property string $mobile
 * @property string $email
 * @property integer $user_id
 */
class Staff extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'staff';
    }

    /**
     * @inheritdoc
     */
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

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'fullname' => 'Fullname',
            'mobile' => 'Mobile',
            'email' => 'Email',
            'user_id' => 'User ID',
        ];
    }
}
