<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Directorio de Geo Developers"}
    <meta name="description" content="Busca por tecnología y encuentra a los mejores profesionales" />
</head>
<body id="members">
{include file="menu.tpl"}
<div id="main-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-md-12 pt0">
                <a href="{$ROOT}">Home</a> &gt;
                {if !isset($TECH)}
                    Miembros
                {else}
                    <a href="{$ROOT}members/">Miembros</a> &gt; {$TECH}
                {/if}
            </div>

            <div class="col-md-8 mt0">
                <form action="" method="GET" id="search-form">
                    <div class="form-group">

                        <label class="search">Filtrar:</label>
                        <div id="input-container">
                            <div class="input-group">
                            <span class="input-group-btn">
                                <div class="btn btn-default pull-left" type="button" data-toggle="modal" data-target="#modalTechs"><i class="fa fa-question-circle fa-lg"></i></div>
                            </span>
                                <input name="tech" type="text" autocomplete="off" id="search" class="form-control" data-provide="typeahead"
                                       value="{if isset($TECH)}{$TECH}{/if}"
                                       placeholder="P.e: ArcGIS, Google Maps, Leaflet, etc" >
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-search"></i></button>
                            </span>
                            </div>
                        </div>
                        <p class="mt1">Resultados: {if $USERS|@count == -1}0{else}{$USERS|@count}{/if} de {$TOTALUSERS}</p>



                    </div>
                </form>
            </div>
            <div class="col-md-offset-2 col-md-2 text-right">
                <a href="rankings/" class="btn btn-warning btn-block"><i class="fa fa-trophy"></i> Rankings</a>

                <!-- asd-->
            </div>

        </div>
        <div class="row">
            <ul id="member-list" class="pt0 col-md-12">

            </ul>
            <div class="mb1 pt0 text-center col-md-12">
                <button class="btn btn-primary" id="loadMembers" data-page="0">Ver más <i class="fa fa-refresh" style="margin-left:5px"></i></button>
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
                                algún miembro en la comunidad, pero como actualmente son {$SKILLS|@count} hemos decidido
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
                                        {for $I=0 to $GEOSKILLS|@count-1}<option>{$GEOSKILLS[$I]["name"]}</option>{/for}
                                    </select>
                                    <label class="col-md-3">Otros</label>
                                    <select class="col-md-9 input-group form-control ">
                                        {for $I=0 to $OTHERSKILLS|@count-1}<option>{$OTHERSKILLS[$I]["name"]}</option>{/for}
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
    </div>
    {include file="footer.tpl"}
</div>

{literal}
    <script id="memberTmpl" type="text/x-jsrender">
        <li class="col-md-4" data-userid="{{:meetup_id}}">
            <div class="member-wrapper clearfix">
                <div class="image-wrapper">
                    <div class="picture clearfix" style="background-image: url('{{:photo_url}}')"></div>
                </div>
                <p class="mb0"><a href="{{:meetup_id}}" class="capitalize">{{:name}} {{:last_name}}</a></p>
                {{if progress }}
                    <p class="mb05"><small>Porcentaje de perfil completado:</small></p>
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                             style="width: {{:progress}}%">
                            {{:progress}}
                        </div>

                    </div>
                {{/if}}
{/literal}

{if isset($TECH)}
                    {literal}

                        <p><small>Nivel de  {literal} {$TECH} {/literal}:</small></p>
                        <div class="progress">
                            <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                                 style="
                                 {{if level== 0 }} width: 0%;{{/if}}
                                 {{if level== 1 }} width: 7%;{{/if}}
                                 {{if level== 2 }} width: 20%;{{/if}}
                                 {{if level== 3 }} width: 50%;{{/if}}
                                 {{if level== 4 }} width: 75%;{{/if}}
                                 {{if level== 5 }} width: 100%;{{/if}}
                                         "
                                    >
                                {{if level== 0 }} ?{{/if}}
                                {{if level== 1 }} {{/if}}
                                {{if level== 2 }} Básico{{/if}}
                                {{if level== 3 }} Medio{{/if}}
                                {{if level== 4 }} Medio-Alto{{/if}}
                                {{if level== 5 }} Avanzado{{/if}}
                            </div>
                        </div>
                     {/literal}
{/if}
{literal}
            </div>
        </li>
    </script>
{/literal}


<script>

    var SKILLS = [{for $I=0 to $SKILLS|@count-1}"{$SKILLS[$I]["name"]}",{/for}]

    var USERS = [
        {for $I=0 to $USERS|@count-1}
            {
                photo_url: '{if isset($USERS[$I]["photo_url"])} {$USERS[$I]["photo_url"]} {/if}',
                meetup_id: {$USERS[$I]["meetup_id"]},
                name: '{$USERS[$I]["name"]}',
                last_name: '{$USERS[$I]["last_name"]}',
                progress: {if isset($USERS[$I]["progress"])} {$USERS[$I]["progress"]} {else} 0 {/if},
                level: {if isset($USERS[$I]["level"])} {$USERS[$I]["level"]}{else}0{/if}
            },
        {/for}
        ];
    require([
        'jquery',
        'members'
    ],function($, members){
        members.init();
    });
</script>

</body>
</html>