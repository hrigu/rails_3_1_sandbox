log = function(txt) {
    $("#log").append("<p>" + txt + "</p>");
};

//dom ready
$(document).ready(function() {
    log("dom ready");
    $(".draggable").draggable({
        helper: 'clone',
        opacity: 0.35
    });
    $(".target").droppable(
        {
            drop: function(event, ui) {
                var dropped = ui.draggable[0];
                var droppedOn = $(this);
                droppedOn.css({"background": dropped.id});
                log(droppedOn[0].id);
                var index = droppedOn[0].id.match(/\d+/);
               // log(index)

                $("#guess_"+index).val(dropped.id);

            }
        }

    );

});
