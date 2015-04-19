<?php

$this->title = Yii::$app->params['brandName'] . ' ' . Yii::$app->params['projectName'];
?>
<?php $this->registerCssFile(Yii::$app->homeUrl . 'css/storelocator/map.css') ?>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="<?php echo Yii::$app->homeUrl . 'js/storelocator/handlebars-1.0.0.js' ?>"></script>
<script src="<?php echo Yii::$app->homeUrl . 'js/storelocator/jquery.storelocator.js' ?>"></script>

<div class="site-index">

    <div class="body-content">
        <div class="row">

            <div class="col-sm-12">
<!--                <div id="form-container">-->
<!--                    <form id="user-location" method="post" action="#">-->
<!--                        <div id="form-input">-->
<!--                            <label for="address">Enter Address or Zip Code:</label>-->
<!--                            <input type="text" id="address" name="address" />-->
<!--                        </div>-->
<!---->
<!--                        <button id="submit" type="submit">Submit</button>-->
<!--                    </form>-->
<!--                </div>-->

                <div id="map-container">
                    <div id="loc-list">
                        <ul id="list"></ul>
                    </div>
                    <div id="map"></div>
                </div>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript">
    jQuery(function($) {
        $('#map-container').storeLocator();
    });
</script>
