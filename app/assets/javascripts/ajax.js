$(document).ready(function() {

    //attach a jQuery live event to the button
    $('#getdata-button').live('click', function() {
        //on click: fetch the json data and show it in the shodata element
        $.getJSON('ajax/json_data', function(data) {
            $('#showdata').html("<p>" + data.name + "</p><p>" + data.age + "</p>");
        });
    });

    $(".place").draggable({
        containment: 'parent',
        stop: function(event, ui) {
            $.post("ajax/post_data", { id: this.id, position: ui.position, authenticity_token: AUTH_TOKEN},
                function(data) {
                    alert("Data Loaded: " + data);
                });
        }
    });
});