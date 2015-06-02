/**
 * Created by JFog on 5/22/15.
 */

var LoopDuration = 20;
var StationID = $('#station_id').val();

jQuery(document).ready(function() {
    setInterval('CronjobStationDetails', LoopDuration*1000);
});

function CronjobStationDetails() {

    $.ajax({
        type: 'POST',
        url: '/cronjob/cronjobstation/details',
        data: {
            'StationID' : StationID
        }
    });

}
