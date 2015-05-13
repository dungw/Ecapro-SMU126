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
        <th class="td-alarm" width="" colspan="4" class="td-alarm">Cảnh báo</th>
        <th class="td-connect" width="25%" colspan="3">Kết nối</th>
        <th class="td-security" width="25%" colspan="3">Báo động</th>
    </tr>
    <tr>
        <th class="td-alarm">Có</th>
        <th class="td-alarm">Không</th>
        <th class="td-alarm"></th>
        <th class="td-alarm">Lần cuối</th>
        <th class="td-connect">Kết nối</th>
        <th class="td-connect">Mất kết nối</th>
        <th class="td-connect"></th>
        <th class="td-security">Bật</th>
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
                    <div class="kv-attribute"><?=$data[$area['id']]['no_warning']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$lastWarningTime?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['connected']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['lost_connect']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['security_on']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['security_off']?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
            </tr>
            <?php
        }
    }
    ?>

</table>