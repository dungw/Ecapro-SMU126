<?php
use Yii;
use yii\web\Controller;
use common\models\Station;
use frontend\modules\cronjob\models\CronjobStationModel;

class CronjobStationController extends Controller {

    public $enableCsrfValidation = false;

    public function setStationID($id) {
        $this->station_id = $id;
        return $this;
    }

    public function getStationID() {
        return $this->station_id;
    }

    public function actionDetails($idStation) {
        $model = new CronjobStationModel();

        // station ID
        $idStation = Yii::$app->request->post('StationID');
        if ($idStation > 0) {

            // get equipment status
            $data['equips'] = $model->findEquipmentStatus($idStation);

            // get dc equipment status
            $data['dc_equips'] = $model->findDcEquipmentStatus($idStation);

            // get sensor status
            $data['sensors'] = $model->findSensorStatus($idStation);

            // get power status
            $data['power_equips'] = $model->findPowerStatus($idStation);
        }

        return json_encode($data);
    }

}