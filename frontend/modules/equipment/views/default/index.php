<?php
use yii\helpers\Html;
use yii\grid\GridView;
use yii\helpers\Url;

$this->title = 'Thiết bị của trạm';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="equipment-index">

    <h4><?= Html::encode($this->title) ?></h4>

    <form name="equipment" action="<?=Url::toRoute('/equipment/default/index')?>" method="post">
        <input type="hidden" name="ids" value="<?=$ids?>">
        <table class="detail-view table table-hover table-bordered">
            <tr>
                <th width="5%">#</th>
                <th width="40%">Tên thiết bị</th>
                <th width="45%">Thứ tự</th>
            </tr>

            <?php
            if (!empty($equipments)) {
                $no = 1;
                foreach ($equipments as $equip) {
                    ?>
                    <tr>
                        <th style="text-align: center"><?=$no?></th>
                        <td>
                            <div class="kv-attribute"><?=$equip->name?></div>
                        </td>
                        <td>
                            <div class="kv-attribute">
                                <span>D</span>
                                <input type="text" name="sort[<?=$equip->id?>]" value="<?=$equip->sort?>">
                            </div>
                        </td>
                    </tr>
                    <?php
                    $no++;
                }
            }
            ?>
        </table>
        <button type="submit" class="btn btn-primary">Cập nhật</button>
    </form>

</div>
