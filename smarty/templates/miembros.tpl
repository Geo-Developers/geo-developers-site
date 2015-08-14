<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="members-page">
{include file="menu.tpl" title="Comunidad de Geo Developers"}

<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-top: 42px;">
            <a href="../">Home</a> &gt; Miembros
        </div>

        <div class="col-md-4 mt0">
            <form action="" method="GET" id="search-form">
                <div class="form-group">

                    <label class="search">Filtrar:</label>
                    <div id="input-container">
                        <div class="input-group">
                            <input name="tech" type="text" autocomplete="off" id="search" class="form-control" data-provide="typeahead"
                                   value="{if isset($TECH)}{$TECH}{/if}"
                                   placeholder="P.e: ArcGIS, Google Maps, Leaflet, etc" >
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-search"></i></button>
                                </span>
                        </div>
                    </div>
                    <p class="mt1">Resultados: {if $NUMUSERS == -1}0{else}{$NUMUSERS}{/if} de {$TOTALUSERS}</p>



                </div>
            </form>
        </div>
        <div class="col-md-offset-4 col-md-2 text-right">
            <a href="rankings/" class="btn btn-warning btn-block"><i class="fa fa-trophy"></i> Rankings</a>

            <!-- asd-->
        </div>
        <div class="col-md-2  text-right">

            <button class="btn btn-default btn-block" data-toggle="modal" data-target="#modalTechs"><i class="fa fa-question-circle fa-lg"></i> Tecnologías</button>
            <!-- asd-->
        </div>
    </div>
    <div class="row">

        <ul id="member-list" class="pt0 col-md-12">
            {for $I=0 to $NUMUSERS-1}

                <li class="col-md-4" data-userid="{$USERS[$I]["meetup_id"]}">
                    <div class="member-wrapper clearfix">
                        <div class="image-wrapper">
                            {if isset($USERS[$I]["photo_url"])}

                                <div class="picture clearfix" style="background-image: url('{$USERS[$I]["photo_url"]}')">
                                </div>

                            {else}
                                Sin foto<br>
                            {/if}
                        </div>
                        <p><a href="{$USERS[$I]["meetup_id"]}" class="capitalize">{$USERS[$I]["name"]}</a></p>
                        {if isset($USERS[$I]["progress"])}
                            <p><small>Porcentaje de perfil completado:</small></p>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                                     style="width: {$USERS[$I]["progress"]}%">
                                    {if $USERS[$I]["progress"] != 0}{$USERS[$I]["progress"]}%{/if}
                                </div>

                            </div>
                        {/if}
                        {if isset($USERS[$I]["level"])}
                            <p><small>Nivel de {$TECH}:</small></p>
                            <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                                 style="
                                 {if $USERS[$I]["level"] == 0 } width: 10%;{/if}
                                 {if $USERS[$I]["level"] == 1 } width: 25%;{/if}
                                 {if $USERS[$I]["level"] == 2 } width: 50%;{/if}
                                 {if $USERS[$I]["level"] == 3 } width: 75%;{/if}
                                 {if $USERS[$I]["level"] == 4 } width: 100%;{/if}
                                         "
                                    >
                                {if $USERS[$I]["level"] == 0 } ?{/if}
                                {if $USERS[$I]["level"] == 1 } Básico{/if}
                                {if $USERS[$I]["level"] == 2 } Medio{/if}
                                {if $USERS[$I]["level"] == 3 } Avanzado{/if}
                                {if $USERS[$I]["level"] == 4 } Experto{/if}
                            </div>
                        {/if}
                    </div>
                </li>

            {/for}
        </ul>
    </div>
</div>

</div>

<div class="modal fade" id="modalTechs" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Tecnologías</h4>
            </div>
            <div class="modal-body">
                <p>
                    <small>El buscador permite filtrar por cualquier conocimiento o aptitud que tenga
                    algún miembro en la comunidad, pero como actualmente son {$NUMSKILLS} hemos decidido
                    que en las sugerencias sólo se muestren las relacionadas con el geo-desarrollo.</small>
                </p>
                <p>
                    <small>Igualmente aquí te dejamos una lista de todos los conocimientos y aptitudes de la base
                    de datos para que sepas por qué valores puedes buscar:</small>
                </p>

                <form class="clearfix form-inline">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-md-3 mt1 mb1">Geo-Desarrollo:</label>
                            <select class="col-md-9 input-group form-control mt1 mb1">
                                {for $I=0 to $NUMGEOSKILLS-1}<option>{$GEOSKILLS[$I]["name"]}</option>{/for}
                            </select>
                            <label class="col-md-3">Otros</label>
                            <select class="col-md-9 input-group form-control ">
                                {for $I=0 to $NUMSKILLS-1}<option>{$SKILLS[$I]["name"]}</option>{/for}
                            </select>
                        </div>
                    </div>
                </form>

                <p class="mt2">
                    <small>Si echas en falta alguna tecnología o conocimiento GIS puedes colaborar sugiriendolo
                    en esta <a href="https://docs.google.com/spreadsheets/d/1Ewzh5miL5Kh4Qqb3d49pnKXq-zC3Bv7I6lOnbjW0kL8/edit?usp=sharing" rel="popover" data-placement="bottom" data-img="{$ROOT}images/thumb-up.gif">hoja de cálculo de Google Drive</a>. La identificación de estas
                    tecnologías es muy importante para ayudar a los miembros tanto a buscar profesionales
                    como a la hora de completar su perfiles, por lo que cualquier ayuda es bienvenida.</small>
                </p>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

{include file="footer.tpl"}
<script>

    var GEOSKILLS = [{for $I=0 to $NUMGEOSKILLS}"{$GEOSKILLS[$I]["name"]}",{/for}]
    require([
        'jquery',
        'members'
    ],function($, members){
        members.init();
    });
</script>
</body>
</html>