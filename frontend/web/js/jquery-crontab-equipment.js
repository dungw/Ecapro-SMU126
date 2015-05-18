
var PANEL = '.panel-equipment';
var TIME_LOOP_STATION = 20;
var LOADING_IMAGE = '<img class="loading" src="/images/loading.gif" />';
var CONFIGURE_AUTO = 0;
var CONFIGURE_MANUAL = 1;
var STATUS_ON = 1;
var STATUS_OFF = 0;

jQuery(document).ready(function() {
    setInterval(updateEquipmentStatus, TIME_LOOP_STATION * 1000);
});

function updateEquipmentStatus() {
    var station_id = $('#station_id').val();
    $.ajax({
        type: 'post',
        url: '/station/default/cron-equipment-status',
        data: {
            station_id: station_id
        },
        beforeSend: function() {
            $(PANEL).append(LOADING_IMAGE);
        },
        success: function(json) {
            $(PANEL).find('.loading').remove();

            var data = $.parseJSON(json);
            var content = data['content'];

            for (var i=0; i<content.length; i++) {
                var prefix = '#equip-'+content[i]['id'];
                var hrefAuto = '/station/default/change-station-part?part=equip&id=' + content[i]['id'] + '&station_id=' + station_id + '&status=' + content[i]['status'] + '&configure=' + CONFIGURE_AUTO;
                var hrefOn = '/station/default/change-station-part?part=equip&id=' + content[i]['id'] + '&station_id=' + station_id + '&status=' + STATUS_ON + '&configure=' + CONFIGURE_MANUAL;
                var hrefOff = '/station/default/change-station-part?part=equip&id=' + content[i]['id'] + '&station_id=' + station_id + '&status=' + STATUS_OFF + '&configure=' + CONFIGURE_MANUAL;

                if (content[i]['configure'] == CONFIGURE_AUTO) {
                    makeup(prefix+'-auto');
                    cleanMakeup(prefix+'-on', hrefOn);
                    cleanMakeup(prefix+'-off', hrefOff);
                } else if (content[i]['configure'] == CONFIGURE_MANUAL && content[i]['status'] == STATUS_ON) {
                    makeup(prefix+'-on');
                    cleanMakeup(prefix+'-auto', hrefAuto);
                    cleanMakeup(prefix+'-off', hrefOff);
                } else if (content[i]['configure'] == CONFIGURE_MANUAL && content[i]['status'] == STATUS_OFF) {
                    makeup(prefix+'-off');
                    cleanMakeup(prefix+'-auto', hrefAuto);
                    cleanMakeup(prefix+'-on', hrefOn);
                }
            }
        }
    });
}

function makeup(id) {
    var obj = $(id);
    var currentClass = $(obj).attr('class');
    if (currentClass != 'text-underline') {
        $(obj).removeAttr('class');
        $(obj).addClass('text-underline');
        $(obj).attr('href', '#');
    }
}

function cleanMakeup(id, href) {
    var obj = $(id);
    $(obj).removeAttr('class');
    $(obj).attr('href', href);
}
