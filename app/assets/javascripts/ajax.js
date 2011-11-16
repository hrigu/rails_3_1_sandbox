$(document).ready(function() {

    //attach a jQuery live event to the button
    $('#getdata-button').live('click', function() {
        //on click: fetch the json data and show it in the shodata element
        $.getJSON('ajax/json_data', function(data) {
            $('#showdata').html("<p>" + data.name + "</p><p>" + data.age + "</p>");
        });
    });

    $('.place').ajaxSend(function(event, request, settings) {
        alert("ajaxSend: " + settings.url);
        settings.data = (settings.data ? settings.data + "&" : "")
            + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
    });
    $(".place").draggable({
        containment: 'parent',
        stop: function(event, ui) {
            $.post("ajax/post_data", { position: ui.position},
                function(data) {
                    alert("Data Loaded: " + data);
                });
        }
    });
});