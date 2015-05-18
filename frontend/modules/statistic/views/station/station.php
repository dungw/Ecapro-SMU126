<?php
$selectedToday = (isset($_GET['get_by']) && $_GET['get_by'] == 'today') ? 'selected="selected"' : '';
$selectedWeek = (isset($_GET['get_by']) && $_GET['get_by'] == 'week') ? 'selected="selected"' : '';
$selectedMonth = (isset($_GET['get_by']) && $_GET['get_by'] == 'month') ? 'selected="selected"' : '';

$getBy = isset($_GET['get_by']) ? $_GET['get_by'] : 'today';
?>
<!--<div style="margin-bottom: 10px;">-->
<!--    <form id="select-by" action="--><?//= Yii::$app->homeUrl . 'statistic/station' ?><!--">-->
<!--        <select name="get_by" style="padding: 5px 20px; cursor: pointer; background-color: #E2EDE3;">-->
<!--            <option --><?//=$selectedToday?><!-- value="today">Hôm nay</option>-->
<!--            <option --><?//=$selectedWeek?><!-- value="week">Tuần này</option>-->
<!--            <option --><?//=$selectedMonth?><!-- value="month">Tháng này</option>-->
<!--        </select>-->
<!--    </form>-->
<!--</div>-->
<div class="panel panel-primary">
    <div class="panel-heading">
        <h4 class="panel-title">
            <i class="glyphicon glyphicon-book"></i>Thống kê trạm
        </h4>
    </div>
</div>
<table class="detail-view table table-hover table-bordered th-center">
    <tr>
        <th width="15%" rowspan="2">Vùng</th>
        <th class="td-alarm" width="" colspan="5" class="td-alarm">
            <span>Cảnh báo</span>

        </th>
        <th class="td-connect" width="25%" colspan="4">Kết nối</th>
        <th class="td-security" width="25%" colspan="4">Báo động</th>
    </tr>
    <tr>
        <th class="td-alarm">Có</th>
        <th class="td-alarm"></th>
        <th class="td-alarm">Không</th>
        <th class="td-alarm"></th>
        <th class="td-alarm">Lần cuối</th>
        <th class="td-connect">Kết nối</th>
        <th class="td-connect"></th>
        <th class="td-connect">Mất kết nối</th>
        <th class="td-connect"></th>
        <th class="td-security">Bật</th>
        <th class="td-security"></th>
        <th class="td-security">Tắt</th>
        <th class="td-security"></th>
    </tr>
    <?php
    if (isset($areas) && !empty($areas)) {
        foreach ($areas as $area) {
            $lastWarningTime = ($data[$area['id']]['last_warning_time'] > 0) ? date('d/m/Y h:i A', $data[$area['id']]['last_warning_time']) : '';
            ?>
            <tr>
                <td>
                    <div class="kv-attribute"><?=$area['name']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['has_warning']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="<?= Yii::$app->homeUrl.'station/default/index?area_id='.$area['id'].'&has_warning=yes&get_by='.$getBy ?>" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['no_warning']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="<?= Yii::$app->homeUrl.'station/default/index?area_id='.$area['id'].'&has_warning=no&get_by='.$getBy ?>" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$lastWarningTime?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['connected']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="<?= Yii::$app->homeUrl.'station/default/index?area_id='.$area['id'].'&connect=yes' ?>" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['lost_connect']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="<?= Yii::$app->homeUrl.'station/default/index?area_id='.$area['id'].'&connect=no' ?>" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['security_on']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="<?= Yii::$app->homeUrl.'station/default/index?area_id='.$area['id'].'&security=on' ?>" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['security_off']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="<?= Yii::$app->homeUrl.'station/default/index?area_id='.$area['id'].'&security=off' ?>" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
            </tr>
            <?php
        }
    }
    ?>

</table>
<script type="text/javascript">
    jQuery(function ($) {
        $('#select-by select').change(function() {
            $(this).parent().submit();
        });
    });
</script>