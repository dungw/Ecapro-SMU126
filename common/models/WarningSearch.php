<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\Warning;

/**
 * WarningSearch represents the model behind the search form about `common\models\Warning`.
 */
class WarningSearch extends Warning
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'warning_type', 'station_id', 'warning_time', 'read'], 'integer'],
            [['message'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = Warning::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->andFilterWhere([
            'id' => $this->id,
            'warning_type' => $this->warning_type,
            'station_id' => $this->station_id,
            'warning_time' => $this->warning_time,
            'read' => $this->read,
        ]);

        $query->andFilterWhere(['like', 'message', $this->message]);

        return $dataProvider;
    }
}
