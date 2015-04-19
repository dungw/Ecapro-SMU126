<?php
use common\components\helpers\Convert;

$this->title = 'Thống kê trạng thái trạm '. $model->name;
$this->params['breadcrumbs'][] = ['label' => 'DS Trạm', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<h4>Danh sách cập nhật trạng thái</h4>
<table class="detail-view table table-hover table-bordered">
    <tr>
        <th width="5%">#</th>
        <th width="30%">Trạng thái đầu vào</th>
        <th width="30%">Trạng thái đầu ra</th>
        <th>Thời gian</th>
    </tr>

    <?php
    if (!empty($status)) {
        $no = 1;
        foreach ($status as $s) {
            ?>
            <tr>
                <th style="text-align: center"><?=$no?></th>
                <td>
                    <div class="kv-attribute"><?= $s->input_data . '&nbsp;-&nbsp;' . Convert::dec2Bin($s->input_data, Yii::$app->params['binary_length']) ?></div>
                </td>
                <td>
                    <div class="kv-attribute"><?= $s->output_data . '&nbsp;-&nbsp;' . Convert::dec2Bin($s->output_data, Yii::$app->params['binary_length']) ?></div>
                </td>
                <td><?=date('d/m/Y - H:i:s A', $s->time_update)?></td>
            </tr>
            <?php
            $no++;
        }
    }
    ?>
</table>