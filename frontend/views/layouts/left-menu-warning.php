<?php
/**
 * Created by PhpStorm.
 * User: JFog
 * Date: 7/16/2015
 * Time: 12:33 AM
 */

use common\components\helpers\Show;
use common\components\helpers\Convert;
use common\models\Area;
use common\models\Center;
use common\models\Station;

$areaList = Area::find()->all();
$centerList = Center::find()->all();
$collections = Station::find()
    ->select('id, name')
    ->all();

$stationList[] = ['id' => 0, 'name' => 'Chọn trạm'];
if (!empty($collections)) {
    foreach ($collections as $col) {
        $stationList[] = ['id' => $col->id, 'name' => $col->name];
    }
}
//print '<pre>'; print_r($stationList); die;
?>
<!-- Filter -->
<form role="form" style="display: block; margin-bottom: 10px;" action="" method="get">
    <!--<input type="hidden" id="station_id" name="station_id" value="<?/*=isset($station) ? $station['id'] : ''*/?>">
        <div class="col-sm-3" style="padding-left: 0px !important;">
            <div class="form-group" style="margin-bottom: 5px !important;">
                <input class="form-control" id="searchinput" type="search" placeholder="Tìm tên trạm..." />
            </div>
            <div id="searchlist" style="position: absolute; width: 100%; padding-right: 15px;" class="list-group"></div>
            <div id="station">
                <?php
    /*                if (isset($station)) {
                        */?>
                    <div>
                        <button class="btn btn-success btn-xs"><?/*=$station['name']*/?></button><img class="delete-station" src="<?/*=Yii::getAlias('@web/images/delete.png')*/?>">
                    </div>
                    <?php
    /*                }
                    */?>
            </div>
        </div>-->

    <div class="filter-item" style="margin-top: 30px;">
        <?=Show::datePicker('from_date', (isset($_GET['from_date']) ? Convert::date2date($_GET['from_date'], 'd/m/Y', 'm/d/Y') : ''), 'Start date')?>
    </div>
    <div class="filter-item">
        <?=Show::datePicker('to_date', (isset($_GET['to_date']) ? Convert::date2date($_GET['to_date'], 'd/m/Y', 'm/d/Y') : ''), 'End date')?>
    </div>
    <div class="filter-item">
        <select onchange="filter_area()" name="area">
            <option value="">- Chọn tỉnh thành -</option>
            <?php
            if (isset($areaList)) {
                foreach ($areaList as $area) {
                    ?>
                    <option value="<?= $area->id ?>"><?= $area->name ?></option>
                    <?php
                }
            }
            ?>
        </select>
    </div>
    <div class="filter-item">
        <select onchange="filter_center()" name="center">
            <option value="">- Chọn trung tâm -</option>
            <?php
            if (isset($centerList)) {
                foreach ($centerList as $center) {
                    ?>
                    <option value="<?= $center->id ?>"><?= $center->name ?></option>
                    <?php
                }
            }
            ?>
        </select>
    </div>
    <div class="filter-item">
        <?= Show::multiSelect('station', array(), $stationList, 'id', 'name', '', ['class' => 'stations', 'style' => 'height: 300px;']) ?>
    </div>
    <div class="filter-item">
        <button type="submit" class="btn btn-primary btn-xs">Tìm kiếm</button>
    </div>
</form>
<style type="text/css">
    .filter-item {
        margin-bottom: 15px;
    }
    .filter-item input, .filter-item select {
        padding: 2px 5px;
        width: 90%;
    }
    .stations {

    }
</style>
