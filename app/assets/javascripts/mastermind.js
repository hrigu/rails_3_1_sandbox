//dom ready
other_select = function(selected){
 // alert(selected);
  if (selected == "game_solver" )
    return "game_master";
  else
    return "game_solver";

};

toggle_value = function(value){
    if (value == "Computer")
        return 1;
    else
        return 0;
}


$(document).ready(function() {
    $(".draggable").draggable({
        helper: 'clone',
        opacity: 0.35
    });
    $(".target").draggable({
        helper: 'clone',
        opacity: 0.35,
        //   (self).css("background-color": white)
        stop: function(event, ui) {
            var draggable = $(this);
            draggable.removeAttr("style");
            // alert(draggable[0].id);
            //draggable.css("background-color", "white");
            var index = draggable[0].id.match(/\d+/);
            // log(index)

            $("#guess_" + index).val("");

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

                $("#guess_" + index).val(background_color);

            },
            hoverClass: 'drophover'

        }


    );
//    $(':input').select(function() {
//        alert('Handler for .test() called.');
//    });


    $('select').change(function() {
        var who = $(this);
        var val = $(this).val();
  //      alert(val);

        $("#"+other_select(who[0].id)).prop('selectedIndex', toggle_value(val));
        //alert (other_select(who[0].id));
    });


});
