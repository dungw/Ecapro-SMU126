<?php

namespace common\models;

use Yii;
use common\models\Base;

/**
 * This is the model class for table "center".
 *
 * @property integer $id
 * @property string $name
 *
 * @property Station[] $stations
 */
class Center extends Base
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'center';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['name'], 'required'],
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
            'name' => 'Tên trung tâm',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getStations()
    {
        return $this->hasMany(Station::className(), ['center_id' => 'id']);
    }

    public static function _prepareDataSelect($collections, $key, $value, $addFirst = true) {
        $data = [];
        if ($addFirst) $data[0] = 'Chọn trung tâm';
        return parent::_prepareDataSelect($collections, $key, $value, $data);
    }
}
