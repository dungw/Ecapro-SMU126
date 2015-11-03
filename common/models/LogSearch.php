<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;

/**
 * LogSearch represents the model behind the search form about `common\models\Log`.
 */
class LogSearch extends LogModel
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'user_id', 'station_id', 'related_id', 'time'], 'integer'],
            [['action'], 'safe'],
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
        $query = LogModel::find();

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        //join
        $query->innerJoin('user u', 'u.id = log.user_id');
        $query->leftJoin('station s', 's.id = log.station_id');
        $query->leftJoin('equipment e', 'e.id = log.related_id');

        $this->load($params);

        /*if (!$this->validate()) {
            // uncomment the following line if you do not want to any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }*/

        $query->andFilterWhere([
            'id' => $this->id,
            'related_id' => $this->related_id,
            'time' => $this->time,
        ]);

        //filter by user name
        $query->andFilterWhere(['like', 'u.username', $this->user_id]);

        //filter by station name
        $query->andFilterWhere(['like', 's.name', $this->station_id]);

        //filter by equipment name
        $query->andFilterWhere(['like', 'e.name', $this->related_id]);

        //filter by action
        $query->andFilterWhere(['like', 'action', $this->action]);

        //order by time
        $query->orderBy('time DESC');

        return $dataProvider;
    }
}
