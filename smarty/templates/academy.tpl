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
            <a href="../">Home</a> &gt; Academy
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 box text-left" style="padding-top: 10px;">
            <form>
                <div class="form-group">
                    <div class="col-md-8">
                        <div class="input-group">
                            <input type="text" id="search" class="form-control" placeholder="">
                              <span class="input-group-btn">
                                <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-search"></i></button>
                              </span>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <select name="filter" class="form-control" id="filter">
                            <option value="">Filtrar</option>
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
                                <a href="view.php?id={$VIDEOS[$I].id}" class="image featured">
                                    <img src="https://i.ytimg.com/vi/{$VIDEOS[$I].id}/mqdefault.jpg" alt="" />
                                    <span class="duration">{$VIDEOS[$I].duration}</span>
                                </a>
                            </div>
                            <div class="col-md-9">
                                <p><a href="view.php?id={$VIDEOS[$I].id}" class="title">{$VIDEOS[$I].title}</a></p>

                                <div class="details">
                                    <span><i class="glyphicon glyphicon-eye-open"></i>{$VIDEOS[$I].viewCount}</span>
                                    <span><i class="glyphicon glyphicon-thumbs-up"></i>{$VIDEOS[$I].likeCount}</span>
                                    <span><i class="glyphicon glyphicon-calendar"></i>{$VIDEOS[$I].publishedAt}</span>
                                </div>

                                <div class="tags">
                                    Etiquetas: <ul>{$VIDEOS[$I].tags}</ul>
                                </div>
                            </div>
                        </div>
                    </div>
                {/for}
            </div>
        </div>
        <div class="col-md-3 col-md-offset-1">
            <div class="row box mb3">
                Buscamos voluntarios para dar charlas
            </div>
            <div class="row box mb3">
                Propón una charla
            </div>
            <div class="row box mb3">
                Recursos
            </div>
            <div class="row box mb3">
                Bolsa de trabajo
            </div>
        </div>
    </div>

</div>



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