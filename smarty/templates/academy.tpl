<!DOCTYPE HTML>
<html>
<head>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    {include file="header.tpl" title="Eventos y vídeos - Geo Developers"}
    <meta name="description" content="Plataforma de formación en GIS: vídeos, transparencias, etc." />
</head>
<body class="video-list" id="academy">
{include file="menu.tpl"}
<div id="main-wrapper">
<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-bottom:20px">
            <a href="../../">Home</a> &gt; Eventos y vídeos
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 box text-left" style="padding-top: 10px;">
            <form>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="input-group">
                                <input type="text" id="search" class="form-control" autocomplete="off">
                                  <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-search"></i></button>
                                  </span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <select name="filter" class="form-control" id="filter">
                                <option value="">Filtrar</option>
                                {for $K=0 to $TAGS|@count - 1}
                                    <option data-name="{$TAGS[$K]}">{$TAGS[$K]}</option>
                                {/for}
                            </select>
                        </div>
                    </div>
                </div>
            </form>
            <hr>
            <div class="row" id="video-list">
                {for $I=0 to $NUMVIDEOS}
                    <div class="col-md-12 video" data-tags="{$VIDEOS[$I].tags}" data-title="{$VIDEOS[$I].title}">
                        <div class="row">
                            <div class="col-md-3">
                                <a href="{$VIDEOS[$I].youtubeId}/view" class="image featured">
                                    <img src="https://i.ytimg.com/vi/{$VIDEOS[$I].youtubeId}/mqdefault.jpg" alt="" />
                                    <span class="duration">{$VIDEOS[$I].duration}</span>
                                </a>
                            </div>
                            <div class="col-md-9">
                                <p><a href="{$VIDEOS[$I].youtubeId}/view" class="title">{$VIDEOS[$I].title}</a></p>

                                <div class="details">
                                    <span><i class="glyphicon glyphicon-eye-open"></i>{$VIDEOS[$I].viewCount}</span>
                                    <span><i class="glyphicon glyphicon-thumbs-up"></i>{$VIDEOS[$I].likeCount}</span>
                                    <span><i class="glyphicon glyphicon-calendar"></i>{$VIDEOS[$I].publishedAt}</span>
                                </div>

                                <div class="tags">
                                    Etiquetas:
                                    <ul>
                                        {for $J=0 to $VIDEOS[$I]["arrayTags"]|@count-1}
                                            <li><a href="#{$VIDEOS[$I]["arrayTags"][$J]}">{$VIDEOS[$I]["arrayTags"][$J]}</a></li>
                                        {/for}
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                {/for}
                <div class="col-md-12" id="no-results">
                    <div class="row">
                        <div class="col-md-3">
                            <a href="{$ROOT}academy/suggest" class="image featured">
                                <img src="{$ROOT}images/suggestionbox.png" alt="">
                            </a>
                        </div>
                        <div class="col-md-9 text-center">
                            <p class="mb1 mt1 big">¿No encuentras lo que buscas?, sugiere un vídeo</p>
                            <a class="btn btn-primary btn-block mb1" href="{$ROOT}academy/suggest">Sugerir un vídeo</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-md-offset-1">
            <div class="row box mb3 give-a-talk">
                <div class="col-md-12">
                    <p class="strong mt0 mb0 pt0 uppercase">Próximos eventos</p>
                    <img src="{$ROOT}images/speaking-image.gif" alt="Uncle sam" style="width:100%" class="thumbnail mb1">
                    <button class="btn btn-success btn-block mb1 blink_me" data-toggle="modal" data-target="#speak"
                            mp-name="Click give a talk">
                        ¡Anímate a dar una charla!
                    </button>
                    <p class="pt0 mt0 pb0"><a href="{$ROOT}academy/webinars" class="small">Ver próximos eventos</a></p>
                </div>
            </div>
            <div class="row box mb3">
                <img src="{$ROOT}images/suggestionbox.png" alt="Uncle sam" style="width:100%" class="thumbnail mb1">
                <a href="suggest" class="btn btn-primary btn-block mb1" >Sugerir un vídeo</a>
            </div>
        </div>
    </div>

</div>

{include file="blocks/give-a-talk.tpl"}


{literal}
    <script id="videoTmpl" type="text/x-jsrender">
        {{if #index == 0}}<hr>{{/if}}
        {{if #index % 3 == 0}}
           <div class="row">
        {{/if}}
        <div class="col-md-4">
            <article class="thumbnail" onclick="selectVideo(this)" data-url="https://www.youtube.com/watch?v={{:id.videoId}}">
                <div class="image featured mb05">
                    <img src="https://i.ytimg.com/vi/{{:id.videoId}}/mqdefault.jpg" alt="" />
                    <i class="fa fa-plus-square"></i>
                </div>
                <div class="table">
                    <p><a href="https://www.youtube.com/watch?v={{:id.videoId}}" target="_blank" title="{{:snippet.title}}">{{:snippet.title}}</a></p>
                </div>
            </article>
        </div>
        {{if ((#index % 3) + 1) % 3 == 0}}
           </div>
        {{/if}}
    </script>
{/literal}
{include file="footer.tpl"}
<script>
    require([
        'jquery',
        'academy'
    ],function($, academy){
        academy.init("videos");
    });
</script>
</div>
</body>
</html>