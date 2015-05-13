<div style="margin-bottom: 10px;">
    <select name="get_by" style="padding: 5px 20px; cursor: pointer; background-color: #E2EDE3;">
        <option value="today">Hôm nay</option>
        <option value="week">Tuần này</option>
        <option value="month">Tháng này</option>
    </select>
</div>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h4 class="panel-title">
            <i class="glyphicon glyphicon-book"></i>Thống kê cảnh báo
        </h4>
    </div>
</div>
<table class="detail-view table table-hover table-bordered th-center">
    <tr>
        <th width="30%" rowspan="2">Vùng</th>
        <th class="td-alarm" width="" colspan="4" class="td-alarm">Cảnh báo</th>
    </tr>
    <tr>
        <th class="td-alarm">Số lượng</th>
        <th class="td-alarm"></th>
        <th class="td-alarm">Bắt đầu</th>
        <th class="td-alarm">Kết thúc</th>
    </tr>
    <?php
    if (isset($areas) && !empty($areas)) {
        foreach ($areas as $area) {
            $begin = ($data[$area['id']]['start'] > 0) ? date('d/m/Y h:i A', $data[$area['id']]['start']) : '';
            $end = ($data[$area['id']]['end'] > 0) ? date('d/m/Y h:i A', $data[$area['id']]['end']) : '';
            $number = $data[$area['id']]['number'];
            ?>
            <tr>
                <td>
                    <div class="kv-attribute"><?=$area['name']?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$number?></div>
                </td>
                <td>
                    <div class="kv-attribute">
                        <a href="" target="_blank" class="btn btn-primary btn-xs">Chi tiết</a>
                    </div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$begin?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?=$end?></div>
                </td>
            </tr>
        <?php
        }
    }
    ?>

</table>