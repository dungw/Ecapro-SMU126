<?php
use common\components\helpers\Show;
use common\components\helpers\Convert;
?>

<form role="form" style="display: block; margin-bottom: 10px;" action="" method="get">
    <div class="filter-item" style="margin-top: 30px;">
        <?=Show::datePicker('from_date', (isset($_GET['from_date']) ? Convert::date2date($_GET['from_date'], 'd/m/Y', 'm/d/Y') : ''), 'Start date')?>
    </div>
    <div class="filter-item">
        <?=Show::datePicker('to_date', (isset($_GET['to_date']) ? Convert::date2date($_GET['to_date'], 'd/m/Y', 'm/d/Y') : ''), 'End date')?>
    </div>
    <div class="filter-item">
        <select onchange="filter();" name="area" id="filter-area">
            <option value="0">- Chọn tỉnh thành -</option>
            <?php
            if (isset($areaList)) {
                foreach ($areaList as $area) {
                    $selected = '';
                    if (isset($_GET['area']) && $_GET['area'] == $area['id']) {
                        $selected = 'selected="selected"';
                    }
                    ?>
                    <option <?= $selected ?> value="<?= $area->id ?>"><?= $area->name ?></option>
                <?php
                }
            }
            ?>
        </select>
    </div>
    <div class="filter-item">
        <select onchange="filter()" name="center" id="filter-center">
            <option value="0">- Chọn trung tâm -</option>
            <?php
            if (isset($centerList)) {
                foreach ($centerList as $center) {
                    $selected = '';
                    if (isset($_GET['center']) && $_GET['center'] == $center['id']) {
                        $selected = 'selected="selected"';
                    }
                    ?>
                    <option <?= $selected ?> value="<?= $center->id ?>"><?= $center->name ?></option>
                <?php
                }
            }
            ?>
        </select>
    </div>
    <div class="filter-item">
        <?= Show::multiSelect('station', isset($_GET['station']) ? $_GET['station'] : [], $stationList, 'id', 'name', '', ['class' => 'stations', 'style' => 'height: 300px;']) ?>
    </div>
    <div class="filter-item">
        <button type="submit" class="btn btn-primary btn-xs">Tìm kiếm</button>
    </div>
</form>