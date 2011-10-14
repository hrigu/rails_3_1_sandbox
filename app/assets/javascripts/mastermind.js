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
    $(".target").draggable({
        helper: 'clone',
        opacity: 0.35,
     //   (self).css("background-color": white)
        stop: function(event, ui){
            var draggable = $(this);
            draggable.removeAttr("style");
           // alert(draggable[0].id);
            //draggable.css("background-color", "white");
            var index = draggable[0].id.match(/\d+/);
            // log(index)

             $("#guess_"+index).val("");

        }
    });
    $(".target").droppable(
        {
            drop: function(event, ui) {
                var droppedOn = $(this);
                var dropped = ui.draggable[0];
                var background_color = dropped.getAttribute('color');
                droppedOn.attr('color', background_color);
                droppedOn.css({"background-color": background_color});
                var index = droppedOn[0].id.match(/\d+/);
               // log(index)

                $("#guess_"+index).val(background_color);

            },
            hoverClass: 'drophover'

        }


    );

});
