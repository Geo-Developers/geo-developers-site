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
				<div class="col-md-12">
					<div class="breadcum">
						<a href="{$ROOT}">Home</a> &gt;
                            {if $TYPE === "academy"}
                            <a href="{$ROOT}/academy">
                                Eventos y vídeos
                            </a>
                            {else}
                            <a href="{$ROOT}/webinars">
                                Webinars
                            </a>
                            {/if}
                            &gt;
						        <span class="title">{$VIDEO.title}</span>
					</div>
					
				</div>
			</div>
			<div class="row">
			  <div class="col-md-6">
                <div id="youtubeVideo"></div>
                <div class="text-center clearfix" id="videoBar">
                    <div>
                        <button class="btn btn-default btn-xs btn-block"><i class="fa fa-thumbs-o-up"></i> Me gusta</button>
                    </div>
                    <div>
                        <button class="btn btn-default btn-xs  btn-block"><i class="fa fa-plus"></i> Suscribir</button>
                    </div>
                    <div>
                        <button class="btn btn-default btn-xs  btn-block"><i class="fa fa-bullhorn"></i> Dar una charla</button>
                    </div>
                </div>
		  	  </div>
			  <div class="col-md-6">
			  	<!--<div id="spinner"><img src="{$ROOT}assets/css/images/spinner.gif"></div>-->
			  	{if $TYPE !== "academy"}
                  <div id="firechat-wrapper"></div>
                {else}
                    <div id="youtube-index">
                        {for $I=0 to $VIDEO.videoIndex|@count-1}
                            <div class="index btnSeek {if $VIDEO.progress[$I][1] == 1}viewed{/if}"
                                 data-seek="{$VIDEO.videoIndex[$I].seconds}">
                                <span class="time">
                                    {$VIDEO.videoIndex[$I].time}
                                    <i class="fa fa-play-circle"></i>
                                </span>
                                <span class="text">
                                    {$VIDEO.videoIndex[$I].text}
                                </span>
                                <span class="view"><i class="fa fa-eye"></i></span>
                            </div>
                        {/for}
                    </div>
                    <div id="progress-container" class="clearfix">
                        <div class="progress-bar"
                             role="progressbar"
                             aria-valuenow="60"
                             aria-valuemin="0"
                             aria-valuemax="100"
                             style="0%"
                        >
                            <span class="text"><span class="percentage">0</span>% Completado</span>
                        </div>
                    </div>
                {/if}
			  </div>
			</div>

			<div class="row">
				<div class="col-md-6" id="ppts">
                    <div role="tabpanel">

                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            {if $VIDEO.slides}
                                <li role="presentation" class="active"><a href="#slides" aria-controls="slides" role="tab" data-toggle="tab">Transparencias</a></li>
                            {/if}
                            {if $TYPE === "academy"}
                                <li role="presentation"><a href="#resources" aria-controls="resources" role="tab" data-toggle="tab">Materiales</a></li>
                            {/if}
                        </ul>
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="slides">
                                {if $VIDEO.slides}
                                    <iframe src="{$VIDEO.slides}" style="width:100%;1px solid #ccc" frameborder="0" height="320" ></iframe>
                                {/if}
                            </div>
                            <div role="tabpanel" class="tab-pane" id="resources">
                                Materiales
                            </div>
                        </div>
                    </div>
				</div>

				<div class="col-md-6">
					<div role="tabpanel">

					  <!-- Nav tabs -->
					  <ul class="nav nav-tabs" role="tablist">
                          <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Descripción</a></li>
                          {if $TYPE === "academy"}
                            <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Preguntas</a></li>
                          {/if}
                          <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">Relacionados</a></li>
					  </ul>


					  <!-- Tab panes -->
					  <div class="tab-content">
					    <div role="tabpanel" class="tab-pane active" id="home">
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
                        {if $TYPE === "academy"}
					        <div role="tabpanel" class="tab-pane" id="profile">
                                <div id="disqus_thread"></div>
                            </div>
                        {/if}
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
        var videoID = {$VIDEO.id},
            youtubeID = "{$VIDEO.youtubeId}",
            fechaEvento = "{$VIDEO.eventDate}",
            transparencias = "",


            meetupid = "{$VIDEO.meetup_id}",

            firechat = "{$VIDEO.firechatID}",

            indexes = [{for $I=0 to $VIDEO.videoIndex|@count-1}{$VIDEO.videoIndex[$I].seconds},{/for}];

            progress= [
                {for $I=0 to $VIDEO.progress|@count-1}
                    [{$VIDEO.progress[$I][0]}, {$VIDEO.progress[$I][1]}, {$VIDEO.progress[$I][2]}],
                {/for}
            ];

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