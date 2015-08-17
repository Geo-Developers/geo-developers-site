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
        <div class="col-md-12" style="margin-top: 70px;margin-bottom:20px">
            <a href="../../">Home</a> &gt; Academy
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 box text-left" style="padding-top: 10px;">
            <form>
                <div class="form-group">
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
            </form>
            <hr>
            <div class="row" id="video-list">
                {for $I=0 to $NUMVIDEOS}
                    <div class="col-md-12 video" data-tags="{$VIDEOS[$I].tags}" data-title="{$VIDEOS[$I].title}">
                        <div class="row">
                            <div class="col-md-3">
                                <a href="{$VIDEOS[$I].id}" class="image featured">
                                    <img src="https://i.ytimg.com/vi/{$VIDEOS[$I].youtubeId}/mqdefault.jpg" alt="" />
                                    <span class="duration">{$VIDEOS[$I].duration}</span>
                                </a>
                            </div>
                            <div class="col-md-9">
                                <p><a href="{$VIDEOS[$I].youtubeId}" class="title">{$VIDEOS[$I].title}</a></p>

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
                            <a href="#" class="image featured">
                                <img src="{$ROOT}images/suggestionbox.png" alt="">
                            </a>
                        </div>
                        <div class="col-md-9 text-center">
                            <p class="mb1 mt1 big">¿No encuentras lo que buscas?, sugiere un vídeo</p>
                            <button class="btn btn-primary btn-block mb1" data-toggle="modal" data-target="#suggestVideo">Sugerir un vídeo</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-md-offset-1">
            <div class="row box mb3">
                <div class="col-md-12">
                    <p class="strong mt0 mb0 pt0 uppercase">Próximos eventos</p>
                    <img src="{$ROOT}images/speaking-image.gif" alt="Uncle sam" style="width:100%" class="thumbnail mb1">
                    <button class="btn btn-warning btn-block mb1 blink_me" data-toggle="modal" data-target="#speak">
                        ¡Anímate a dar una charla!
                    </button>
                    <p class="pt0 mt0 pb0"><a href="{$ROOT}webinars" class="small">Ver próximos eventos</a></p>
                </div>
            </div>
            <div class="row box mb3">
                <img src="{$ROOT}images/suggestionbox.png" alt="Uncle sam" style="width:100%" class="thumbnail mb1">
                <button class="btn btn-primary btn-block mb1" data-toggle="modal" data-target="#suggestVideo">Sugerir un vídeo</button>
            </div>
        </div>
    </div>

</div>


<div class="modal fade" id="speak" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Razones para dar una charla</h4>
            </div>
            <div class="modal-body">
                <div class="small">
                <ol class="numbered-list">
                    <li>Aportar tu granito de arena a la comunidad.</li>
                    <li>Todos te agradeceremos que compartas tus conocimientos/experiencias.</li>
                    <li>Aprenderás, una de las mejores y más gratificantes formas de aprender es enseñando.</li>
                    <li>Ganarás visibilidad, te conocerán más personas y harás más contactos.</li>
                    <li>Te posicionarás mejor en la mente de los miembros de la comunidad.</li>
                    <li>Si te da un poco de vergüenza hablar en público te irás quitando ese lastre.</li>
                </ol>
                <p>
                    Y quien sabe... a lo mejor hasta te ayuda a recibir alguna oferta interesante.
                </p>
                <p><strong>Sobre el tipo de charlas:</strong></p>
                <p>
                    Será bienvenida cualquier que pueda ayude a mejorar las habilidades necesarias a la hora
                    de crear una aplicación con datos geolocalizados o que requiera resolver problemas espaciales.<br>
                    Por tanto <span class="underline">no sólo las de desarrollo</span>, sino también de
                    uso de herramientas que puedan ser útiles a la hora de manipular datos geográficos,
                    sistemas de referencia, bases de datos espaciales, etc.
                </p>
                <p class="text-center">
                    <strong>¿Te animas?</strong> <i class="fa fa-smile-o"></i>
                </p>
                <p class="text-center">
                    <button class="btn btn-warning" id="speakBtn">Ok, contad conmigo para alguna charla <i class="fa fa-thumbs-o-up"></i></button>
                </p>
                <p>
                    <strong>Nota</strong>: hay personas que creen que no tienen suficiente nivel o que al resto
                    les va a parecer que muy simple lo que van a explicar, pero recordad, aunque creas que no
                    sepas tanto de algo <span class="underline">siempre hay personas que saben menos</span>.
                </p>
                <p>

                </p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="suggestVideo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Sugerir un vídeo</h4>
            </div>
            <div class="modal-body small">
                <p>Si conoces algún vídeo que creas que creas que deberíamos añadir por favor indícanos cual:</p>
                <form id="searchVideo">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-search"></i></button>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div id="searchResults" class=" text-center">


                    </div>
                    <div class="row mt0 text-center" id="suggestBtn" style="display:none">
                        <div class="col-md-12">
                            <button class="btn btn-primary">Enviar <i class="fa fa-plus"></i></button>
                        </div>
                    </div>

                    <div class="row mt0 text-center disabled" id="suggestDone" style="display:none">
                        <div class="col-md-12">
                            <button class="btn btn-success disabled">¡Gracias!, revisaremos la petición cuanto antes <i class="fa fa-check"></i></button>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
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
            <article class="thumbnail" onclick="$(this).toggleClass('selected');">
                <a href="https://www.youtube.com/watch?v={{:id.videoId}}" target="_blank" class="image featured mb05"><img src="https://i.ytimg.com/vi/{{:id.videoId}}/mqdefault.jpg" alt="" /></a>
                <div class="table">
                    <p>{{:snippet.title}}</p>
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
</body>
</html>