<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Comunidad de Geo Developers"}
	
		<meta name="description" content="Vídeo, PPTs, chat ... y mucho más!" />
		<meta property="og:image" content="http://geodevelopers.org/streaming/images/geodevelopers.png"/>

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

	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<link rel="stylesheet" href="{$ROOT}assets/css/view.css">

		<!-- Latest compiled and minified JavaScript -->
		<script src="{$ROOT}assets/js/view.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.3.1/js/bootstrap-modal.min.js"></script>


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
			<div class="col-md-12">
				<h1 class="breadcum"><a href="../">Home</a> &gt; <a href="/videos">Eventos</a> &gt; <span class="title"></span></h1>
				
			</div>
		</div>
		<div class="row">
		  <div class="col-md-6" id="youtubeVideo">
		  	
	  	  </div>
		  <div class="col-md-6">
		  	<div id="spinner"><img src="{$ROOT}assets/css/images/spinner.gif"></div>
		  	<div id="firechat-wrapper"></div>
		  	<div id="youtube-index"></div>
		  </div>
		</div>
		<div class="row">
			<div class="col-md-6 padding-top-0" id="ppts">
				<!--<iframe src="https://docs.google.com/presentation/d/16wNWpNhnzxVxQ1TXPccERxBfi_q2T8sKBMHHbi6rcOg/embed?start=false&loop=false&delayms=3000" frameborder="0" width="640" height="389" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>-->
				
			</div>
			<div class="col-md-6 padding-top-0">
				<div role="tabpanel">

				  <!-- Nav tabs -->
				  <ul class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Preguntas</a></li>
				    <li role="presentation"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Descripción y Recursos</a></li>
				    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Relacionados</a></li>
				    <!--<li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">Amigos</a></li>-->
				  </ul>

				  <!-- Tab panes -->
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="home">
					    <div class="descripcion"></div>
					    <p style="margin-top:20px;"><strong>Otros recursos</strong></p>
					    <ul id="resources" class="style-none">
					    	<li class="ppts">Transparencias</li>
					    	<li class="meetup">Ver evento en Meetup</li>
					    	<li class="youtube"><a href="https://www.youtube.com/channel/UC5Kegds6aV88wjdAhqQ5Wsg?sub_confirmation=1">Suscríbete al canal de Youtube</a></li>
					    </ul>

					    
				    </div>

				    <div role="tabpanel" class="tab-pane active" id="profile">
				    	<div id="disqus_thread"></div>
							{literal}
							<script type="text/javascript">
							    /* * * CONFIGURATION VARIABLES * * */
							    var disqus_shortname = 'geodevelopers';
							    
							    /* * * DON'T EDIT BELOW THIS LINE * * */
							    (function() {
							        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
							        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
							        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
							    })();
							</script>
							<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
							{/literal}
				    </div>
				    <div role="tabpanel" class="tab-pane" id="messages">
				    	<ul id="related" class="style-none">
				    		
				    	</ul>
							{literal}
				    	<script id="videoTmpl" type="text/x-jsrender">
							{{for data}}
							<li onclick=view("{{:videoid}}") title="{{:videoTitle}}">
				        <img src='https://i.ytimg.com/vi/{{:videoid}}/default.jpg'>
				        <div class='videoDesc'>
				          <p class='videoTitle'>{{:videoTitle}}</p>
				        </div>
				      </li>
				      {{/for}}
							</script>
							{/literal}
				    </div>
				    <div role="tabpanel" class="tab-pane" id="settings">...</div>
				  </div>

				</div>
			</div>
		</div>
		</div>

{include file="footer.tpl"}