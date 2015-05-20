<?php
use Yii;
use yii\web\Controller;
use common\models\Station;
use frontend\modules\cronjob\models\CronjobStationModel;

class CronjobStationController extends Controller {

    public $enableCsrfValidation = false;

    public function actionDetail($idStation) {
        $model = new CronjobStationModel();

        // get equipment status
        $data['equips'] = $model->findEquipmentStatus($idStation);

        // get dc equipment status
        $data['dc_equips'] = $model->findDcEquipmentStatus($idStation);

        //

        return json_encode($data);
    }

}