$(document).ready(function(){
    //attach a jQuery live event to the button
    $('#getdata-button').live('click', function(){
        $.getJSON('ajax/json_data', function(data) {
            $('#showdata').html("<p>"+data.name+"</p><p>"+data.age+"</p>");
        });
    });
});