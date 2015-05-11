<div class="panel panel-primary">
    <div class="panel-heading">
        <h4 class="panel-title">
            <i class="glyphicon glyphicon-book"></i>Thống kê trạm
        </h4>
    </div>
</div>
<table class="detail-view table table-hover table-bordered">
    <tr class="info">
        <th colspan="3"></th>
    </tr>
    <tr>
        <th width="15%" rowspan="2">Vùng</th>
        <th width="" colspan="4">Cảnh báo</th>
        <th width="20%" colspan="2">Kết nối</th>
        <th width="20%" colspan="2">Báo động</th>
    </tr>
    <tr>
        <th>Có</th>
        <th>Không</th>
        <th>Bắt đầu</th>
        <th>Kết thúc</th>
        <th>Kết nối</th>
        <th>Mất kết nối</th>
        <th>Bật</th>
        <th>Tắt</th>
    </tr>
    <?php
    if (isset($areas) && !empty($areas)) {
        foreach ($areas as $area) {
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
                    <div class="kv-attribute"><?=date('d/m/Y H:i', time())?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=date('d/m/Y H:i', time())?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['connected']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['lost_connect']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['security_on']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$data[$area['id']]['security_off']?></div>
                </td>
            </tr>
            <?php
        }
    }
    ?>

</table>