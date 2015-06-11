/**
 * Created by JFog on 6/9/15.
 */
var TIME_LOOP = 20;

jQuery(document).ready(function($) {

    // run after each TIME_LOOP(s)
    setInterval(findUnreadWarning, TIME_LOOP * 1000);
});

function findUnreadWarning() {
    $.ajax({
        url: '/warning/default/latest',
        type: 'post',
        data: {
            time_loop: TIME_LOOP
        },
        beforeSend: function() {
            // do something before send
        },
        success: function(json) {
            var data = $.parseJSON(json);
        }
    });
}
