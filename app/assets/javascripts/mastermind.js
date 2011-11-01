$(document).ready(function() {
    $(".draggable").draggable({
        helper: 'clone',
        opacity: 0.35
    });
    $(".target").draggable({
        helper: 'clone',
        opacity: 0.35,
        stop: function(event, ui) {
            var draggable = $(this);
            draggable.removeAttr("style");
            var index = draggable[0].id.match(/\d+/);
            $("#put_" + index).val("");

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
                $("#put_" + index).val(background_color);

            },
            hoverClass: 'drophover'

        }


    );

});
