<?php

namespace common\models;

use Yii;
use common\models\Base;

/**
 * This is the model class for table "area".
 *
 * @property integer $id
 * @property string $code
 * @property string $name
 *
 * @property Station[] $stations
 */
class Area extends Base
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'area';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['code', 'name'], 'string', 'max' => 100]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'code' => 'Mã khu vực',
            'name' => 'Tên khu vực',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getStations()
    {
        return $this->hasMany(Station::className(), ['area_id' => 'id']);
    }

    public static function _prepareDataSelect($collections, $key, $value, $addFirst = true) {
        $data = [];
        if ($addFirst) $data[0] = 'Chọn khu vực';
        return parent::_prepareDataSelect($collections, $key, $value, $data);
    }
}
