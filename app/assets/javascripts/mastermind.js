log = function(txt){
  $("#log").append("<p>" + txt+ "</p>");
};

//dom ready
$(document).ready(function(){
  log("dom ready");

});
