define(['jquery','jsrender'], function($){
  var Methods = {
    init: function(seccion){
      var youtubeID = window.location.search.split("=")[1],
          api_url = "https://spreadsheets.google.com/feeds/list/14-tvNCiE3Brs4eHbZvuc3B92uQDAYl9qXUMkX1EC5jU/1/public/values?alt=json-in-script&callback=loadVideos";

			$(document).ready(function(){
			  $.ajax({
			    url: api_url,
			    jsonp: "loadVideos",
			    dataType: "jsonp",
			    data: {format: "json"}
			  });
			});

      window.loadVideos = function (data){
        videos = [];
        data = data.feed.entry;

        $.each( data, function( key, val ) { 

          fechaEvento = val["gsx$fechammddaaaa"]["$t"];
          var data = {
            titulo: val["gsx$charla"]["$t"],
            id: val["gsx$idyoutube"]["$t"]
          };
          
          if(seccion == "videos"){
            if (Date.parse(fechaEvento) < Date.now()) {
              videos.push(data); 
            }
          }else{
            if (Date.parse(fechaEvento) >= Date.now()) {
              videos.push(data); 
            }
          }
        });

        var videos = {
	  	  	data: videos
	  	  };
	  	  
	  		template = $.templates("#videoTmpl");
			  htmlOutput = template.render(videos);
			  $("#videoList").html(htmlOutput);
      }

      window.view = function(youtubeID){
          window.location.href='view.php?id='+youtubeID;
      };
    }
  };
  return Methods;
});