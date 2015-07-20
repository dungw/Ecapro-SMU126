<?php
use common\models\Station;
use yii\helpers\Html;
use yii\grid\GridView;
use common\components\helpers\Show;

$this->title = 'Thống kê cảnh báo';
$this->params['breadcrumbs'][] = $this->title;

?>
<script src="<?=Yii::$app->homeUrl?>js/bootstrap-list-filter.src.js"></script>

<link rel="stylesheet" href="<?=Yii::$app->homeUrl?>css/magnific-popup.css">
<div class="warning-index">

    <h4><?= Html::encode($this->title) ?></h4>

    <div style="clear:both"></div>

    <div style="margin-top: 10px;">

        <div style="margin-bottom: 10px">
            <a target="_blank" href="<?= Yii::$app->urlManager->baseUrl . 'export?' . $_SERVER['QUERY_STRING'] ?>" type="button" class="btn btn-primary btn-xs">Export Excel</a>
        </div>

        <?= GridView::widget([
            'dataProvider' => $dataProvider,
            'columns' => [
                [
                    'class' => 'yii\grid\SerialColumn',
                    'options' => [
                        'width' => '6%',
                    ],
                ],
                [
                    'attribute' => 'station_id',
                    'value'     => function($model) {
                            $station = Station::findOne($model->station_id);
                            return $station['name'];
                        },
                    'options' => [
                        'width' => '15%',
                    ],
                ],
                'message',
                [
                    'attribute' => 'warning_time',
                    'value' => function($model) {
                            return date('d/m/Y H:i', $model->warning_time);
                        },
                    'options' => [
                        'width' => '15%',
                    ],
                ],
                [
                    'attribute' => 'picture',
                    'label' => 'Ảnh chụp',
                    'format' => 'raw',
                    'value' => function($model) {
                            $pics = $model->findPicture($model->id);
                            $html = '<div class="gallery">';

                            if (!empty($pics)) {
                                $no = 1;
                                foreach ($pics as $pic) {
                                    $hide = 1;
                                    if ($no == 1) {
                                        $hide = 0;
                                    }
                                    $hideIt = ($hide) ? 'style="display: none;"' : '';
                                    $path = Yii::$app->urlManager->baseUrl . '/uploads/' . $pic['picture'];
                                    $html .= '<button '. $hideIt .' class="btn btn-warning btn-xs" href="'. $path .'">Xem ảnh</button>';
                                    $no++;
                                }
                            } else {
                                $html .= Show::decorateString('Lỗi camera', 'bad');
                            }
                            $html .= '</div>';
                            return $html;
                        },
                    'options' => [
                        'width' => '10%',
                    ],
                ],

            ],
        ]);

        ?>
    </div>
</div>

<script type="text/javascript">

    function addStation(obj) {
        var id = $(obj).attr('id');
        var name = $(obj).find('span').html();
        $('#station_id').val(id);
        $('#station').html('<div><button class="btn btn-success btn-xs">'+name+'</button><img class="delete-station" src="<?=Yii::getAlias('@web/images/delete.png')?>"></div>');
    }

    jQuery(document).ready(function ($) {
        $('.gallery').each(function() { // the containers for all your galleries
            $(this).magnificPopup({
                delegate: 'button', // the selector for gallery item
                type: 'image',
                gallery: {
                    enabled:true
                }
            });
        });

        $('#searchlist').btsListFilter('#searchinput', {
            sourceTmpl: '<a class="list-group-item gi-small list-group-item-success" id="{id}" onclick="addStation(this);" href="#"><span>{name}</span></a>',
            sourceData: function(text, callback) {
                return $.getJSON('/station/default/find?q='+text, function(json) {
                    callback(json);
                });
            }
        });

        $('.delete-station').click(function() {
            $(this).parent().remove();
            $('#station_id').val('');
        });
    });

</script>