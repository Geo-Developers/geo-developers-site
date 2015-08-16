<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Empieza la charla de @GeoDevelopers en directo: "}
	
		<meta name="description" content="Vídeo, PPTs, chat ... y mucho más!" />
		<meta property="og:image" content="http://geodevelopers.org/streaming/images/geodevelopers.png"/>

		<link rel="stylesheet" href="https://cdn.firebase.com/libs/firechat/2.0.1/firechat.min.css" />
		<link rel="stylesheet" href="{$ROOT}assets/css/view.css">
	</head>
	
	<body id="view-page-{$TYPE}">
		{include file="menu.tpl" title="Comunidad de Geo Developers"}

		<div class="container">

			<div class="row">
				<div class="col-md-12" style="margin-top: 72px;">
					<div class="breadcum">
						<a href="{$ROOT}">Home</a> &gt;
                        <a href="index.php">
                            {if $TYPE === "academy"}
                                Academy
                            {else}
                                Webinars
                            {/if}
                        </a> &gt;
						<span class="title">{$VIDEO.title}</span>
					</div>
					
				</div>
			</div>
			<div class="row">
			  <div class="col-md-6" id="youtubeVideo">

		  	  </div>
			  <div class="col-md-6">
			  	<!--<div id="spinner"><img src="{$ROOT}assets/css/images/spinner.gif"></div>-->
			  	{if $TYPE !== "academy"}
                  <div id="firechat-wrapper"></div>
                {else}
                    <div id="youtube-index">
                        {for $I=0 to $VIDEO.videoIndex|@count-1}
                            <div class="index btnSeek" data-seek="{$VIDEO.videoIndex[$I].seconds}">
                            <span>
                                {$VIDEO.videoIndex[$I].time}
                            </span>
                                {$VIDEO.videoIndex[$I].text}
                            </div>
                        {/for}
                    </div>
                {/if}
			  </div>
			</div>

			<div class="row">
				<div class="col-md-6 padding-top-0" id="ppts">

                    {if $VIDEO.slides}
                        <iframe src="{$VIDEO.slides}" style="width:100%;1px solid #ccc" frameborder="0" height="389" ></iframe>
                    {/if}
				</div>

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
						    <div class="descripcion">
                                {$VIDEO.description}
						    </div>
						    <p style="margin-top:20px;"><strong>Otros recursos</strong></p>
						    <ul id="resources" class="style-none">
						    	{if $VIDEO.slides}
                                    <li class="ppts">
                                        <a href='{$VIDEO.slides}' target='_blank'>Transparencias</a>
                                    </li>
                                {/if}
                                {if $VIDEO.meetup_id}
                                    <li class="meetup">
                                        <a href='http://www.meetup.com/es/Geo-Developers/events/{$VIDEO.meetup_id}' target='_blank'>Ver evento en Meetup</a>
                                    </li>
                                {/if}
						    	<li class="youtube"><a href="https://www.youtube.com/channel/UC5Kegds6aV88wjdAhqQ5Wsg?sub_confirmation=1">Suscríbete al canal de Youtube</a></li>
						    </ul>
					    </div>

					    <div role="tabpanel" class="tab-pane active" id="profile">
					    	<div id="disqus_thread"></div>
					    </div>
                        {if $VIDEO.related}
					    <div role="tabpanel" class="tab-pane" id="messages">
					    	<ul id="related" class="style-none">
                                {for $I=0 to $VIDEO.related|@count-1}
                                    <li title="{$VIDEO.related[$I].title}">
                                        <a href="{$VIDEO.meetup_id}">
                                            <img src='https://i.ytimg.com/vi/{$VIDEO.related[$I].youtubeId}/default.jpg'>
                                        </a>
                                        <div class='videoDesc'>
                                            <p class='videoTitle'><a href="{$VIDEO.related[$I].meetup_id}">{$VIDEO.related[$I].title}</a></p>
                                        </div>
                                    </li>
                                {/for}

                            </ul>
					    </div>
                        {/if}
					  </div>

					</div>
				</div>
			</div>
		</div>

	{include file="footer.tpl"}
	<script>
        var youtubeID = "{$VIDEO.youtubeId}",
            fechaEvento = "{$VIDEO.eventDate}",
            transparencias = "",


            meetupid = "{$VIDEO.meetup_id}",

            firechat = "{$VIDEO.firechatID}";

	 	require([
  		'jquery',
  		'view'
  	],function($, view){
  		view.init("{$TYPE}");
  	});

    {if $TYPE === "academy"}
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//geodevelopers.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
    {/if}
	</script>
</body>
</html>