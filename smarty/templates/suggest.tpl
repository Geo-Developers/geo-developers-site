<!DOCTYPE HTML>
<html>
<head>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="video-suggest">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<div id="main-wrapper">
<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-bottom:20px">
            <a href="{$ROOT}">Home</a> &gt; <a href="{$ROOT}/academy">Academy</a> &gt; Sugerir vídeos
        </div>
    </div>
    <div class="row">
        <div class="col-md-9 box">

            <div class="row">
                <div class="col-md-6" id="submit-url">
                    <label>Añadir por URL: </label>

                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="fa fa-plus"></i></button>
                                </span>
                    </div>
                </div>

                <div class="col-md-6"  id="searchVideo">
                    <label>Buscar en Youtube: </label>

                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="">
                        <span class="input-group-btn">
                            <button class="btn btn-default search" type="button"><i class="glyphicon glyphicon-search"></i></button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="searchResults" class=" text-center">


                    </div>
                    <div class="row mt0" id="youtubeNavigation" style="display:none">

                        <div class="col-md-offset-4 col-md-4 text-center">
                            <button class="btn btn-primary" id="loadMore">Ver más <i class="fa fa-refresh"></i></button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-2 col-md-offset-1 box small text-left" id="confirm">
            <div class="row">
                <div class="col-md-12 text-center strong uppercase">
                    <p class="none">Añade algún vídeo</p>
                    <p class="pending" style="display:none">Seleccionados</p>
                </div>
                <div class="col-md-12 pt0 confirm-list">
                    <ul class="mb0"></ul>
                </div>
                <div class="col-md-12">
                    <button class="btn btn-primary btn-block disabled">Enviar <i class="fa fa-check"></i></button>
                </div>
            </div>

            <div class="row mt0 text-center disabled" id="suggestDone" style="display:none">
                <div class="col-md-12 text-center pt0">
                    <p class="alert alert-success">¡Gracias!, revisaremos la petición cuanto antes.</p>
                    <button class="btn btn-default">Añadir más</button>
                </div>
            </div>
        </div>
    </div>



</div>



{literal}
    <script id="videoTmpl" type="text/x-jsrender">
        <div class="video-item">
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
    </script>

    <script id="confirmTpl" type="text/x-jsrender">
        <li>
            <i class="fa fa-times" onclick="deleteElem(this)" data-url="{{:url}}"></i> <a href="{{:url}}" target="_blank">{{:title}}</a>
        </li>
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
</div>
</body>
</html>