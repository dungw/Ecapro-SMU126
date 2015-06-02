<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "station_type".
 *
 * @property integer $id
 * @property string $name
 * @property integer $active
 */
class StationType extends Base
{
    const STATUS_ACTIVE = 1;
    const STATUS_INACTIVE = 0;

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'station_type';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
            [['id', 'active'], 'integer'],
            [['name'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Tên',
            'active' => 'Active',
        ];
    }

    public function isActive() {
        return ($this->active == self::STATUS_ACTIVE) ? true : false;
    }

    public function setActive($active) {
        $this->active = $active;
        return $this;
    }


    public static function optionsActive() {
        return [
            self::STATUS_ACTIVE => 'Sử dụng',
            self::STATUS_INACTIVE => 'Không sử dụng',
        ];
    }

    public function getActive() {
        $options = self::optionsActive();
        foreach ($options as $optKey => $optValue) {
            if ($this->active == $optKey) {
                return $optValue;
            }
        }
        return null;
    }

}
