<?php
use common\models\EquipmentStatus;
use common\models\DcEquipmentStatus;
use common\models\SensorStatus;

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Trạm', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h4 class="panel-title">
            <i class="glyphicon glyphicon-book"></i><?php echo $model->name ?> (<?php echo $model->code ?>)
        </h4>
    </div>
</div>
<table class="detail-view table table-hover table-bordered" style="margin-bottom: 0px;">
    <tr class="info">
        <th colspan="4">Giám sát thiết bị</th>
    </tr>
    <tr>
        <th width="5%">#</th>
        <th>Tên thiết bị</th>
        <th width="10%">Tình trạng</th>
        <th width="30%">Thiết lập</th>
    </tr>

    <?php

    if (isset($equipments) && !empty($equipments)) {
        $no = 1;
        foreach ($equipments as $equipment) {
            ?>
            <tr>
                <th style="text-align: center"><?=$no?></th>
                <td>
                    <div class="kv-attribute"><?=$equipment['name']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=EquipmentStatus::getStatus($equipment['status'])?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <?php
                        $underAuto = 0;
                        $underOn = 0;
                        $underOff = 0;
                        if ($equipment['configure'] == EquipmentStatus::CONFIGURE_AUTO) $underAuto = 1;
                        if ($equipment['configure'] == EquipmentStatus::CONFIGURE_MANUAL && $equipment['status'] == EquipmentStatus::STATUS_ON) $underOn = 1;
                        if ($equipment['configure'] == EquipmentStatus::CONFIGURE_MANUAL && $equipment['status'] == EquipmentStatus::STATUS_OFF) $underOff = 1;
                        ?>
                        <a class="<?=(isset($underOn) && $underOn == 1) ? 'text-underline' : ''?>" href="">Bật</a>  /
                        <a class="<?=(isset($underOff) && $underOff == 1) ? 'text-underline' : ''?>" href="">Tắt</a>  /
                        <a class="<?=(isset($underAuto) && $underAuto == 1) ? 'text-underline' : ''?>" href="">Tự động</a>
                    </div>
                </td>
            </tr>
            <?php
            $no++;
        }
    }
    ?>



</table>

<table class="detail-view table table-hover table-bordered">
    <tr>
        <th width="5%">#</th>
        <th>Thiết bị</th>
        <th width="20%">Dòng điện</th>
        <th width="20%">Điện áp</th>
    </tr>
    <tr>
        <td rowspan="2" style="vertical-align: middle; text-align: center">Tủ DC</td>
        <?php
        if (!empty($model->dc_equip_status)) {
            foreach ($model->dc_equip_status as $equipStatus) {
                ?>
                <td>
                    <div class="kv-attribute"><?=$equipStatus['name']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?= $equipStatus['amperage'] . '&nbsp;' . Yii::$app->params['unit_amperage'] ?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?= $equipStatus['voltage'] . '&nbsp;' . Yii::$app->params['unit_amperage'] ?></div>
                </td>
                </tr>
                <?php
            }
        }
        ?>
</table>

<table class="detail-view table table-hover table-bordered">
    <tr class="info">
        <th colspan="3">Giám sát cảm biến</th>
    </tr>
    <tr>
        <th width="5%">#</th>
        <th width="40%">Cảm biến</th>
        <th width="45%">Tình trạng</th>
    </tr>

    <?php
    if (!empty($model->sensor_status)) {
        $no = 1;
        foreach ($model->sensor_status as $status) {
            ?>
            <tr>
                <th style="text-align: center"><?=$no?></th>
                <td>
                    <div class="kv-attribute"><?= $status['name'] . '&nbsp;(' . SensorStatus::getUnit($status['unit']) . ')' ?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$status['value']?></div>
                </td>
            </tr>
            <?php
            $no++;
        }
    }
    ?>
</table>

<table class="detail-view table table-hover table-bordered">
    <tr class="info">
        <th colspan="3">Giám sát hệ thống nguồn điện</th>
    </tr>
    <tr>
        <th width="5%">#</th>
        <th width="40%">Hạng mục</th>
        <th width="45%">Thông số</th>
    </tr>
    <tr>
        <th style="text-align: center">1</th>
        <td>
            <div class="kv-attribute">Nguồn điện</div>
        </td>
        <td>
            <div class="kv-attribute">Cấp điện lưới cho tải</div>
        </td>
    </tr>
    <tr>
        <th style="text-align: center">2</th>
        <td>
            <div class="kv-attribute">Máy phát</div>
        </td>
        <td>
            <div class="kv-attribute">OFF</div>
        </td>
    </tr>
</table>

<table class="detail-view table table-hover table-bordered">
    <tr class="info">
        <th colspan="2">Thông tin trạm</th>
    </tr>
    <tr>
        <td width="50%">
            <div class="kv-attribute">
                <b>Trung tâm: </b><span><?php echo $model->center->name ?></span>
            </div>
        </td>
        <td width="50%">
            <div class="kv-attribute">
                <b>Khu vực: </b><span><?php echo $model->area->name ?></span>
            </div>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <div class="kv-attribute">
                <b>Người trực: </b><span><?php echo $model->staff ?></span>
            </div>
        </td>
        <td width="50%">
            <div class="kv-attribute">
                <b>Điện thoại: </b><span><?php echo $model->phone ?></span>
            </div>
        </td>
    </tr>
    <tr>
        <td width="50%">
            <div class="kv-attribute">
                <b>Email: </b><span><?php echo $model->email ?></span>
            </div>
        </td>
        <td></td>
    </tr>
    <tr>
        <td colspan="2">
            <div class="kv-attribute">
                <b>Thông tin thêm: </b><span><?php echo $model->addition ?></span>
            </div>
        </td>
    </tr>
</table>