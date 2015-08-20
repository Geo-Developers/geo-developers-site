<!DOCTYPE HTML>
<html>
<head>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body class="video-list" id="academy-listing">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-bottom:20px">
            <a href="{$ROOT}">Home</a> &gt; <a href="{$ROOT}/academy">Academy</a> &gt; Sugerir vídeos
        </div>
    </div>
    <div class="row">

        <div id="searchVideo">

            <div class="col-md-12">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="">
                                <span class="input-group-btn">
                                    <button class="btn btn-default search" type="button"><i class="glyphicon glyphicon-search"></i></button>
                                </span>
                </div>
            </div>

            <div id="searchResults" class=" text-center">


            </div>
            <div class="row mt0" id="youtubeNavigation" style="display:none">
                <div class="col-md-4 text-left">
                    <button class="btn btn-default disabled before"><i class="fa fa-arrow-left "></i></button>
                </div>
                <div class="col-md-4 text-center">
                    <button class="btn btn-primary" id="suggestBtn">Enviar <i class="fa fa-plus"></i></button>
                </div>
                <div class="col-md-4 text-right">
                    <button class="btn btn-default after"><i class="fa fa-arrow-right"></i></button>
                </div>
            </div>

            <div class="row mt0 text-center disabled" id="suggestDone" style="display:none">
                <div class="col-md-12">
                    <button class="btn btn-success disabled">¡Gracias!, revisaremos la petición cuanto antes <i class="fa fa-check"></i></button>
                </div>
            </div>
        </div>

    </div>
</div>



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
        'suggest'
    ],function($, suggest){
        suggest.init();
    });
</script>
</body>
</html>