/**
 * Created by JFog on 6/9/15.
 */
var TIME_LOOP = 2;

jQuery(document).ready(function($) {

    // run after each TIME_LOOP(s)
    setInterval(findUnreadWarning, TIME_LOOP * 1000);

    function findUnreadWarning() {
        $.ajax({
            url: '/warning/default/cron-unread',
            type: 'post',
            data: {

            },
            beforeSend: function() {
                // do something before send
            },
            success: function(json) {
                var data = $.parseJSON(json);
                if (data['html']) {

                    if ($('#latest-warning-block').hasClass('show')) {

                    } else {

                        // open popup
                        $('#latest-warning-block').dialogBox({
                            type: 'correct',  //three type:'normal'(default),'correct','error',
                            width: 1000,
                            height: 400,
                            hasMask: true,
                            autoHide: false,
                            time: 3000,
                            effect: 'fall',
                            title: 'Cảnh báo mới',
                            content: data['html']
                        });
                    }

                }
            }
        });
    }
});
