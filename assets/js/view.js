define(['jquery','jsrender'], function($){
  var Methods = {
    init: function(){
      var youtubeID = window.location.search.split("=")[1];
          api_url = "https://spreadsheets.google.com/feeds/list/14-tvNCiE3Brs4eHbZvuc3B92uQDAYl9qXUMkX1EC5jU/1/public/values?alt=json-in-script&callback=loadPPTs";

      var rows = [];
      $.getScript('http://www.youtube.com/iframe_api');

      window.loadPPTs = function(data){
        rows = data = data.feed.entry, i = 0;
        $.each( data, function( key, val ) {
          if(val["gsx$idyoutube"]["$t"] == youtubeID){
            
            fechaEvento = val["gsx$fechammddaaaa"]["$t"];
            transparencias = val["gsx$transparencias"]["$t"];
            descripcion = val["gsx$descripcion"]["$t"];
            tags = val["gsx$tags"]["$t"];
            meetupid = val["gsx$meetupid"]["$t"];
            videosrelacionados = val["gsx$videosrelacionados"]["$t"];
            
            cargarContenidos(youtubeID, fechaEvento, transparencias, descripcion, tags, meetupid, videosrelacionados);
          }
          
        });         
      }

      var player;
      function onYouTubePlayerAPIReady() {
         player = new YT.Player('youtubeVideo', {
           height: '280',
           width: '640',
           videoId: youtubeID,
             playerVars: { 'start': 159, 'autoplay': 1, 'controls': 1 },
           events: {
             'onReady': onPlayerReady,
             'onStateChange': onPlayerStateChange,
           }
             
         });         
      }
      function onPlayerStateChange(evt) 
      {
          if (evt.data==1) 
          {
              // this will seek to a certain point when video starts
              // but you're better off using 'start' parameter
              // player.seekTo(22);   
          }
      }

      function onPlayerReady(evt) {
         
        // doesn't work here
        // player.seekTo(30);  
         
         // lets make ure we have a function
         //alert("typeof(player.SeekTo) = " + typeof(player.seekTo));
      }

      $(function() {
          
          $(document).on('click', '.btnSeek', function() {
              player.seekTo($(this).data('seek'), true);
          });
      });

      var calculateSeconds = function(time){
        var vals = time.split(":"),
            num = vals.length-1,
            seconds = parseInt(vals[num]),
            pow = 1;
        
        while (num > 0){
          num--;
          seconds += parseInt(vals[num])*Math.pow(60,pow);
          pow++;
        }
        return seconds;
      }

      var view = function(youtubeID){
          window.location.href='/videos/view.html?id='+youtubeID;
      };

      var cargarContenidos = function(youtubeID, fechaEvento, transparencias, descripcion, tags, meetupid, videosrelacionados){
        
        if(transparencias!=""){
          if(transparencias.substring(0,4)=="http"){
            $("#ppts").append('<iframe src="'+transparencias+'" style="width:100%;1px solid #ccc" frameborder="0" height="389" ></iframe');
          }else{
            $("#ppts").append('<iframe src="https://docs.google.com/presentation/d/'+transparencias+'/embed?start=false&loop=false&delayms=3000" frameborder="0" style="width:100%" height="389" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>');
          }
        }

        $("#home .descripcion").html(descripcion);
        if(transparencias){
          if(transparencias.substring(0,4)=="http"){
            $("#resources .ppts").html("<a href='"+transparencias+"' target='_blank'>Transparencias</a>");
          }else{
            $("#resources .ppts").html("<a href='https://docs.google.com/presentation/d/"+transparencias+"/pub' target='_blank'>Transparencias</a>");
          }
        }else{
          $("#resources .ppts").hide();
        }
        if(meetupid){
          $("#resources .meetup").html("<a href='http://www.meetup.com/es/Geo-Developers/events/"+meetupid+"' target='_blank'>Ver evento en Meetup</a>");
        }else{
          $("#resources .meetup").hide();
        }

        if(videosrelacionados != ""){
          //Cargamos los videos relacionados
          var videos = videosrelacionados.split(","),
              nVideos = rows.length,
              v, template, related={data:[]}, htmlOutput;
          
          for(i=0; i < videos.length; i++){
            v = rows[nVideos-parseInt(videos[i])];
            console.log(v);
              related.data.push({
                videoid: v["gsx$idyoutube"]["$t"],
                videoTitle: v["gsx$charla"]["$t"]
              });
          }
          
          template = $.templates("#videoTmpl");
          htmlOutput = template.render(related);
          $("#related").html(htmlOutput);
        }

        var videoDesc,
            url = "https://www.googleapis.com/youtube/v3/videos?id="+youtubeID+"&part=snippet&key=AIzaSyDki-gYirztPuR0GNGX-0uOuTUowQtq9mI";

        $.getJSON(url , function(data){
          //console.log(data);
          
          $(".title").text(data.items[0].snippet.title);
          $(".st_twitter, .st_linkedin, .st_facebook, .st_googleplus, .st_email").attr("st_title","Charla @GeoDevelopers de "+data.items[0].snippet.title);

          // If it is passed event
          if (Date.parse(fechaEvento) < Date.now()) {
            $("#spinner").hide();

            videoDesc = data.items[0].snippet.description;
            indexes = videoDesc.split("\n");
            desc = "";

            for(i=0 ; i < indexes.length ; i++){
              time = indexes[i].split(" ")[0];
              seconds = calculateSeconds(time);
              text = indexes[i].split(" ").slice(1).join(" ");
              desc += '<div class="index btnSeek" data-seek="'+seconds+'"><span>'+time+'</span> '+text+'</div>';
            }

            
            videoDesc = videoDesc.replace(/(?:\r\n|\r|\n)/g, '<br />');
            $("#youtube-index").html(desc);
            $("#firechat-wrapper").hide();
            $("#youtube-index").css('visibility','visible');
          }else{

            $("#youtube-index").hide();

            jQuery.getScript("https://cdn.firebase.com/js/client/2.0.2/firebase.js", function(){
              jQuery.getScript("https://cdn.firebase.com/libs/firechat/2.0.1/firechat.min.js", function(){
                console.log("cargado!");
                var chatRef = new Firebase("https://blistering-fire-8130.firebaseio.com");
                var chat = new FirechatUI(chatRef, document.getElementById("firechat-wrapper"));
                 
                chatRef.authAnonymously(function(error, authData) {
                  $("#firechat-wrapper").css('visibility','visible');
                  if (error) {
                    console.log("Login Failed!", error);
                  } else {
                    console.log("Authenticated successfully with payload:", authData);
                    if (authData) {
                        chat.setUser(authData.uid, "Anonymous" + authData.uid.substr(10, 8));

                        setTimeout(function() {
                          $("#spinner").hide();
                          $("#firechat #firechat-tab-content").css("border-top","1px solid #bbb");
                          chat._chat.enterRoom('-JgAvXEjG13D3DoIq9mc')
                        },2000);
                      } else {
                        chatRef.authAnonymously(function(error, authData) {
                          if (error) {
                            console.log(error);
                          }
                        });
                      }
                  }
                });
              });
            });
          }
        });
      };
      //
      $(document).ready(function(){
        $("#youtubeVideo").append('<iframe style="width:100%"  height="280" src="//www.youtube.com/embed/'+youtubeID+'" frameborder="0" allowfullscreen></iframe>');
        $.ajax({
          url: api_url,
          jsonp: "loadPPTs",
          dataType: "jsonp",
          data: {format: "json"}
        });
      });

      (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//geodevelopers.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
      })();
    }
  };
  return Methods;
});