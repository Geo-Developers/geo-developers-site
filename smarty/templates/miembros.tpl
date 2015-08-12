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

                        <label>Filtrar:</label>
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
            <a href="" class="mt1" style="display: inline-block"><i class="fa fa-pie-chart fa-lg"></i> Estadísticas</a>

            <!-- asd-->
        </div>
        <div class="col-md-2  text-right">

            <a href="" class="mt1" style="display: inline-block"><i class="fa fa-question-circle fa-lg"></i> Tecnologías</a>
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
                        <p><a href="{$USERS[$I]["meetup_id"]}">{$USERS[$I]["name"]}</a></p>
                        {if isset($USERS[$I]["progress"])}
                            <p><small>Eficacia del perfil:</small></p>
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