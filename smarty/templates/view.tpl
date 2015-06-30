<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Empieza la charla de @GeoDevelopers en directo: "}
	
		<meta name="description" content="Vídeo, PPTs, chat ... y mucho más!" />
		<meta property="og:image" content="http://geodevelopers.org/streaming/images/geodevelopers.png"/>
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		<link rel="stylesheet" href="https://cdn.firebase.com/libs/firechat/2.0.1/firechat.min.css" />
		<link rel="stylesheet" href="{$ROOT}assets/css/view.css">
	</head>
	
	<body id="view-page">
		{include file="menu.tpl" title="Comunidad de Geo Developers"}
		<div class="container">

			<div class="row">
				<div class="col-md-12">
					<h1 class="breadcum">
						<a href="../">Home</a> &gt; 
						<a href="index.php">Academy</a> &gt; 
						<span class="title"></span>
					</h1>
					
				</div>
			</div>
			<div class="row">
			  <div class="col-md-6" id="youtubeVideo">
			  	
		  	  </div>
			  <div class="col-md-6">
			  	<div id="spinner"><img src="{$ROOT}assets/css/images/spinner.gif"></div>
			  	<div id="firechat-wrapper" style="visibility:hidden"></div>
			  	<div id="youtube-index"  style="visibility:hidden"></div>
			  </div>
			</div>
			<div class="row">
				<div class="col-md-6 padding-top-0" id="ppts"></div>

				<div class="col-md-6 padding-top-0">
					<div role="tabpanel">

					  <!-- Nav tabs -->
					  <ul class="nav nav-tabs" role="tablist">
					    <li role="presentation" class="active"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Preguntas</a></li>
					    <li role="presentation"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Descripción y Recursos</a></li>
					    <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Relacionados</a></li>
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
					  </div>

					</div>
				</div>
			</div>
		</div>

	{include file="footer.tpl"}
	<script>
	 	require([
  		'jquery',
  		'view'
  	],function($, view){
  		view.init("{$TYPE}");
  	});
	</script>
</body>
</html>