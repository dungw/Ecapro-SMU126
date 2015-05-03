<?php

namespace common\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use common\models\Station;

/**
 * StationSearch represents the model behind the search form about `common\models\Station`.
 */
class StationSearch extends Station
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['id', 'center_id', 'area_id', 'type', 'user_id', 'status', 'picture_warning_numb'], 'integer'],
            [['code', 'name', 'firmware', 'staff', 'addition', 'picture_url', 'video_url', 'latitude', 'longtitude', 'phone', 'email'], 'safe'],
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
    public function search($params, $condition)
    {
        $query = Station::find()->where($condition);

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => [
                'pageSize' => Yii::$app->params['page_size'],
            ],
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->andFilterWhere([
            'id' => $this->id,
            'center_id' => $this->center_id,
            'area_id' => $this->area_id,
            'type' => $this->type,
            'user_id' => $this->user_id,
            'status' => $this->status,
            'picture_warning_numb' => $this->picture_warning_numb,
        ]);

        $query->andFilterWhere(['like', 'code', $this->code])
            ->andFilterWhere(['like', 'name', $this->name])
            ->andFilterWhere(['like', 'firmware', $this->firmware])
            ->andFilterWhere(['like', 'staff', $this->staff])
            ->andFilterWhere(['like', 'addition', $this->addition])
            ->andFilterWhere(['like', 'picture_url', $this->picture_url])
            ->andFilterWhere(['like', 'video_url', $this->video_url])
            ->andFilterWhere(['like', 'latitude', $this->latitude])
            ->andFilterWhere(['like', 'longtitude', $this->longtitude])
            ->andFilterWhere(['like', 'phone', $this->phone])
            ->andFilterWhere(['like', 'email', $this->email]);

        return ['provider' => $dataProvider, 'query' => $query];
    }
}
