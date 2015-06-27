<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Comunidad de Geo Developers"}
	
		<!-- jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

		<script src="http://www.jsviews.com/download/jsrender.min.js"></script>
		{literal}
		<script type="text/javascript">
		$.getScript("http://www.jsviews.com/download/jsrender.min.js");
			(function () {
	      var s = document.createElement('script');
	      s.type = 'text/javascript';
	      s.async = true;
	      s.src = 'http://www.jsviews.com/download/jsrender.min.js';
	      var x = document.getElementsByTagName('script')[0];
	      x.parentNode.insertBefore(s, x);
	  })();
	  </script>
	  {/literal}


    <!-- Firebase -->
    <script src="https://cdn.firebase.com/js/client/2.0.2/firebase.js"></script>

    <!-- Firechat -->
    <link rel="stylesheet" href="https://cdn.firebase.com/libs/firechat/2.0.1/firechat.min.css" />
    <script src="https://cdn.firebase.com/libs/firechat/2.0.1/firechat.min.js"></script>
		{literal}
    <script type="text/javascript">var switchTo5x=true;</script>
		<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
		<script type="text/javascript">stLight.options({publisher: "c6c82cb4-c766-4e38-bfd1-0d531786e983", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script>
		{/literal}
	</head>
<body>
		{include file="menu.tpl" title="Comunidad de Geo Developers"}
		<div class="container">
			<div class="row">
				<div class="col-md-12" style="margin-top: 70px;margin-bottom: 20px">
					<a href="../">Home</a> &gt; Academy
				</div>
			</div>
		</div>
		
			

		
		
		<div class="container">
			<div class="row" id="videoList">
			{literal}
			<script id="videoTmpl" type="text/x-jsrender">
			{{for data}}
				<div class="4u 12u(mobile)">
					<article class="box style2">
						<a href="#" class="image featured" onclick=view("{{:id}}")><img src="https://i.ytimg.com/vi/{{:id}}/mqdefault.jpg" alt="" /></a>
						<div class="table">
							<p>{{:titulo}}</p>
						</div>
					</article>
				</div>
	    {{/for}}
	    </script>
		<script>
		  	  

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

          var loadVideos = function (data){
            //debugger;
            videos = [];
            data = data.feed.entry;
            

            $.each( data, function( key, val ) { 
              videos.push({
	            	titulo: val["gsx$charla"]["$t"],
	            	id: val["gsx$idyoutube"]["$t"]
	            }); 

              
            });

            var videos = {
			  	  	data: videos
			  	  };
			  	  console.log(videos)
			  		template = $.templates("#videoTmpl");
					  htmlOutput = template.render(videos);
					  $("#videoList").html(htmlOutput);
            
          }

          var view = function(youtubeID){
              window.location.href='view.php?id='+youtubeID;
          };
    		</script>
    		{/literal}

  
	  	  </div>
		</div>

{include file="footer.tpl"}