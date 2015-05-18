var TIME_LOOP_STATION = 20;
var WARNING_PANEL_STATION = '#panel-station';
var LOADING_IMAGE_STATION = '<img class="loading" src="/images/loading.gif" />';
var STATUS_CONNECTED = 1;
var STATUS_CONNECTED_LABEL = '<span style="color: #00BB00;">Đang kết nối</span>';
var STATUS_DISCONNECT = 0;
var STATUS_DISCONNECT_LABEL = '<span style="color: #FF0000;">Mất kết nối</span>';
var SOUND = '/sound/beeps.wav';
var BLOCK_CLASS = '.block-station';
var DISCONNECT_CLASS = 'disconnect';
var CONNECTED_CLASS = 'connected';

jQuery(document).ready(function() {
    setInterval(updateStatus, TIME_LOOP_STATION * 1000);

    // check disconnect station
    checkDisconnect();
});

function updateStatus() {
    var ids = $('#ids').val();
    $.ajax({
        type: 'post',
        url: '/station/default/update-status',
        data: {
            ids: ids
        },
        beforeSend: function() {
            $(WARNING_PANEL_STATION).find('.panel-title').append(LOADING_IMAGE_STATION);
        },
        success: function(json) {
            $(WARNING_PANEL_STATION).find('.loading').remove();

            var data = $.parseJSON(json);
            var content = data['content'];
            var idArr = ids.split(',');
            if (idArr.length > 0) {
                for (var i=0; i<idArr.length; i++) {

                    var status = content[idArr[i]];
                    if (status == STATUS_CONNECTED) {
                        $('#status-' + idArr[i]).find('span').html(STATUS_CONNECTED_LABEL);
                        $('#status-' + idArr[i]).attr('class', CONNECTED_CLASS);
                    }
                    if (status == STATUS_DISCONNECT) {
                        $('#status-' + idArr[i]).find('span').html(STATUS_DISCONNECT_LABEL);
                        $('#status-' + idArr[i]).attr('class', DISCONNECT_CLASS);
                    }
                }
            }

            // check disconnect after update status
            checkDisconnect();
        }
    });
}

// function that check if there are some station lost connect
function checkDisconnect() {
    var countUnread = $(BLOCK_CLASS).find('.'+DISCONNECT_CLASS).length;
    if (countUnread >= 1) {
        playSoundStation();
    }
}

// play sound function
function playSoundStation() {
    var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', SOUND);
    audioElement.setAttribute('autoplay', 'autoplay');
    audioElement.play();
}