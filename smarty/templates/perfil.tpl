<!DOCTYPE HTML>
<html>
<head>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="profile-page">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-top: 70px;margin-bottom:20px;padding-left: 0;">
            <a href="../../">Home</a> &gt; <a href="{$ROOT}miembros">Miembros</a> &gt; Perfil de {$PROFILE["name"]}
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 box text-left" style="padding-top: 10px;position: relative">
            <div class="row">

                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-12">
                            <p id="picture"><img src="{$PROFILE["photo_url"]}"></p>
                            <h1 class="capitalize">{$PROFILE["name"]}</h1>
                        </div>
                    </div>
                    <p class="row">
                        <span class="text-label col-md-4 pt05">Ubicación:</span>
                        <span class="col-md-8 pt05">{$PROFILE["location"]}</span>
                    </p>
                    <p class="row">
                        <span class="text-label col-md-4 pt05">Miembro desde:</span>
                        <span class="col-md-8 pt05">{$PROFILE["joined"]}
                    </p>
                    <p class="row">
                        <span class="text-label col-md-4 pt05">Bio:</span>
                        <span class="col-md-8 pt05">{$PROFILE["bio"]|default:'No disponible'}
                    </p>
                    <p class="row">
                        <span class="text-label col-md-4 pt05">Profesión:</span>
                        <span class="col-md-8 pt05">{$PROFILE["occupation"]|default:'Desconocida'}</span>
                    </p>
                    <p class="row">
                        <span class="text-label col-md-4 pt05">Cargo:</span>
                        <span class="col-md-8 pt05">{$PROFILE["position"]|default:'Desconocido'}</span>
                    </p>
                    <p class="row">
                        <span class="text-label col-md-4 pt05">Estudios:</span>
                        <span class="col-md-8 pt05">{$PROFILE["studies"]|default:'Desconocidos'}</span>
                    </p>
                    <div class="row">
                        <span class="text-label col-md-4 pt05">Perfiles sociales:</span>
                        <ul class="inline col-md-8 pt05" id="social-networks">
                            {if $PROFILE["twitter_url"]}
                                <li>
                                    <a href='{$PROFILE["twitter_url"]}' class="icon twitter" title="{$PROFILE["twitter_name"]}" data-toggle="tooltip" data-placement="bottom">
                                        <i class="fa fa-twitter"></i>
                                        <span class="label">Twitter</span>
                                    </a>
                                </li>
                            {/if}
                            {if $PROFILE["linkedin_url"]}
                                <li>
                                    <a href='{$PROFILE["linkedin_url"]}' class="icon linkedin" title="Linkedin" data-toggle="tooltip" data-placement="bottom">
                                        <i class="fa fa-linkedin"></i>
                                        <span class="label">Linkedin</span>
                                    </a>
                                </li>
                            {/if}
                            {if $PROFILE["github_url"]}
                                <li>
                                    <a href='{$PROFILE["github_url"]}' class="icon github" title="Github" data-toggle="tooltip" data-placement="bottom">
                                        <i class="fa fa-github"></i>
                                        <span class="label">Github</span>
                                    </a>
                                </li>
                            {/if}
                            {if $PROFILE["meetup_url"]}
                                <li>

                                    <a href='{$PROFILE["meetup_url"]}' class="icon meetup" title="Meetup" data-toggle="tooltip" data-placement="bottom">
                                        <i class="fa fa-users"></i>
                                        <span class="label">Meetup</span>
                                    </a>
                                </li>
                            {/if}
                            {if $PROFILE["facebook_url"]}
                                <li>
                                    <a href='{$PROFILE["facebook_url"]}' class="icon facebook" title="Facebook" data-toggle="tooltip" data-placement="bottom">
                                        <i class="fa fa-facebook"></i>
                                        <span class="label">Facebook</span>
                                    </a>
                                </li>
                            {/if}
                            {if $PROFILE["flickr_url"]}
                                <li>
                                    <a href='{$PROFILE["flickr_url"]}' class="icon flickr" title="Flickr" data-toggle="tooltip" data-placement="bottom">
                                        <i class="fa fa-flickr"></i>
                                        <span class="label">Flickr</span>
                                    </a>
                                </li>
                            {/if}
                        </ul>
                    </div>
                </div>
            </div>
            <hr class="clearfix mt1">

            <h2>Conocimientos e intereses:</h2>
            <p class="strong mt2 uppercase">Relacionados con el GeoDesarrollo:</p>
            {if $NUMSKILLSGIS == 0}
                <p>No se ha especificado ninguno</p>
            {else}
                <ul class="row skills">
                    {for $I=0 to $NUMSKILLSGIS-1}
                        <li class="col-md-4">
                            <div class="truncate" >
                                <a href="{$ROOT}miembros/?tech={$SKILLSGIS[$I]["name"]}" data-toggle="tooltip" data-placement="right" title="{$SKILLSGIS[$I]["desc"]}">
                                    {$SKILLSGIS[$I]["name"]}
                                </a>
                            </div>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                                     style="
                                     {if $SKILLSGIS[$I]["level"] == 0 } width: 10%;{/if}
                                     {if $SKILLSGIS[$I]["level"] == 1 } width: 25%;{/if}
                                     {if $SKILLSGIS[$I]["level"] == 2 } width: 50%;{/if}
                                     {if $SKILLSGIS[$I]["level"] == 3 } width: 75%;{/if}
                                     {if $SKILLSGIS[$I]["level"] == 4 } width: 100%;{/if}
                                             "
                                        >
                                    {if $SKILLSGIS[$I]["level"] == 0 } ?{/if}
                                    {if $SKILLSGIS[$I]["level"] == 1 } Básico{/if}
                                    {if $SKILLSGIS[$I]["level"] == 2 } Medio{/if}
                                    {if $SKILLSGIS[$I]["level"] == 3 } Avanzado{/if}
                                    {if $SKILLSGIS[$I]["level"] == 4 } Experto{/if}
                                </div>
                            </div>
                        </li>
                    {/for}
                </ul>
            {/if}

            <hr>

            <p class="strong mt2 uppercase">Otros:</p>
            <ul class="row">
                {if $NUMSKILLS == 0}
                <p>No se ha especificado ninguno</p>
                {else}
                    {for $I=0 to $NUMSKILLS-1}
                        <li class="col-md-4">
                            <a class="truncate" title="{$SKILLS[$I]["name"]}"
                               href="{$ROOT}miembros/?tech={$SKILLS[$I]["name"]}">
                                {$SKILLS[$I]["name"]}
                            </a>
                            <div class="progress">
                                <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                                     style="
                                     {if $SKILLS[$I]["level"] == 0 } width: 10%;{/if}
                                     {if $SKILLS[$I]["level"] == 1 } width: 25%;{/if}
                                     {if $SKILLS[$I]["level"] == 2 } width: 50%;{/if}
                                     {if $SKILLS[$I]["level"] == 3 } width: 75%;{/if}
                                     {if $SKILLS[$I]["level"] == 4 } width: 100%;{/if}
                                             "
                                        >
                                    {if $SKILLS[$I]["level"] == 0 } ?{/if}
                                    {if $SKILLS[$I]["level"] == 1 } Básico{/if}
                                    {if $SKILLS[$I]["level"] == 2 } Medio{/if}
                                    {if $SKILLS[$I]["level"] == 3 } Avanzado{/if}
                                    {if $SKILLS[$I]["level"] == 4 } Experto{/if}
                                </div>
                            </div>
                        </li>
                    {/for}
               {/if}
            </ul>

        </div>
        <div class="col-md-3 col-md-offset-1">
            <div class="row box mb3 text-center">
                <p class="text-label">Eficacia del perfil</p>
                {literal}<script type="text/javascript" src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1.1','packages':['corechart']}]}"></script>
                <div id="donut_single" style="width: 180px; height: 180px;padding:0;margin: 0 45px 15px;" rel="popover"></div>
                <div style="display: none">
                    <div id="donut_info">
                        <div style="font-size: .9em">
                        <p style="margin-bottom: 0"><strong>¿Qué indica la eficacia del perfil?</strong></p>
                        <p>Indica la visibilidad que tiene el perfil dentro de la página.
                        Aumentando la eficacia se mejora la posibilidad de que cualquier
                        visitante de la página encuentre el perfil.</p>
                        <p>Para calcular la eficacia de un perfil se tienen en cuenta si el usuario a indicado:<br>
                        1) Conocimientos GIS y no GIS<br>
                        2) Nivel <u>en todos</u> los conocimientos<br>
                        3) Bio, Profesión, Cargo y Estudios<br>
                        4) Perfiles sociales (Twitter y Linkedin)<br>
                        </p>
                        </div>
                    </div>
                </div>
                <script>{/literal}

                    google.setOnLoadCallback(drawChart);
                    function drawChart() {

                        var data = google.visualization.arrayToDataTable([
                            ['Effort', 'Amount given'],
                            ['Completado',     {$PROFILE["progress"]}],
                            ['Pendiente',     100-{$PROFILE["progress"]}],
                        ]);

                        var options = {
                            pieHole: 0.5,
                            pieSliceTextStyle: {
                                color: 'white'
                            },
                            'chartArea': {
                                'width': '100%',
                                'height': '100%'
                            },
                            legend: 'none',
                            enableInteractivity: false
                        };

                        var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
                        chart.draw(data, options);
                    }

                    {literal}</script>{/literal}
                    {if isset($USER["email"]) && $USER["email"]==$PROFILE["email"]}
                        <a href="{$ROOT}miembros/{$USER["meetup_id"]}/editar" class="btn btn-primary btn-block mb1">Editar perfil</a>
                    {else}
                        <p>
                            <small>
                                {if isset($USER["email"])==false}
                                    ¿Eres tú?, puedes <a href="#">completarlo ahora</a>; o si sabes quién es <a href="#">puedes avísarle</a>.
                                {else}
                                    Si sabes quién es <a href="#">puedes avísarle</a>.
                                {/if}
                            </small>
                        </p>
                    {/if}

                <!--{$PROFILE["progress"]}%<br>-->

            </div>
            <div class="row box mb3 text-center recommendations pb2" id="referrers">
                {if $NREFERRERS == 0 && isset($USER["email"]) && $USER["email"]==$PROFILE["email"]}
                    <p class="text-label col-md-12 mt1 title">Recomendaciones <i class="fa fa-thumbs-o-up"></i></p>
                    <p>
                        <small>
                            Aún no has recibido ninguna recomendación.
                        </small>
                    </p>
                    <p>
                        <small>
                    ¿Por qué no le echas un poquillo'
                            de morro y le haces una
                            "<i rel="popover" data-img="{$ROOT}images/gato_de_srek.gif" style="color:#337ab7;cursor:pointer;text-decoration: underline">kindly suggestion</i>"
                            a los <a href="{$ROOT}miembros">miembros de la comunidad</a> con los
                            que tengas confianza?.<br>
                    </small>
                    </p>
                    <p>
                        <small>
                            Te ayudará a ganar visibilidad en
                            <a href="{$ROOT}miembros/rankings/">el ranking</a>. <i class="fa fa-smile-o"></i>
                    </small>
                    </p>

                {/if}
                <p class="text-label col-md-12 mt1 title" style="{if $NREFERRERS == 0}display:none;{/if}">
                    Recomendado por
                </p>
                <div class="col-md-12 pt0 text-center">
                {for $J=0 to $NREFERRERS-1}
                    <div class="referrer" data-referrer="{$REFERRERS[$J]["meetup_id"]}">
                        <a href="{$ROOT}miembros/{$REFERRERS[$J]["meetup_id"]}"  class="image-wrapper">
                            <span class="picture clearfix" style="background-image: url('{$REFERRERS[$J]["photo_url"]}')"></span>
                        </a>
                    </div>
                {/for}

                {if isset($USER)}
                    <div class="referrer" data-referrer="{$USER["meetup_id"]}" style="display:none;">
                        <a href="{$ROOT}miembros/{$USER["meetup_id"]}" class="image-wrapper">
                            <span class="picture clearfix" style="background-image: url('{$USER["photo_url"]}')"></span>
                        </a>
                    </div>
                {/if}
                </div>


                <div class="col-md-12" style="{if isset($USER) && $USER["email"]==$PROFILE["email"]}display:none{/if}">
                    <p class="pb0">
                        {literal}<script>{/literal}
                            var refered = {$PROFILE["meetup_id"]};
                        {literal}</script>{/literal}
                        <a href="#"
                           class="  btn btn-block
                                    {if {$ISRECOMMENDED}}recommended btn-danger{else}btn-primary{/if}
                                    {if isset($USER) && $USER["email"]==$PROFILE["email"]}disabled{/if}
                                 "
                           id="vote"
                           {if isset({$USER}) == false}data-toggle="modal" data-target="#loginModal"{/if}

                        >
                            <i class="fa fa-times"></i>
                            <i class="fa fa-thumbs-o-up"></i> Recomendar
                        </a>
                    </p>
                    <!-- TODO: Modal con formulario de contacto -->
                    <!--
                    <p class="pb0 pt05">
                        <a href="#" class="btn btn-block
                            {if $PROFILE["email"] && $USER["email"]!=$PROFILE["email"]}
                                btn-danger"
                            {else}
                               disabled btn-default" title="No tenemos sus datos de contacto"
                            {/if}
                        >

                        <i class="fa fa-envelope-o"></i> Contactar
                        </a>
                    </p>
                    -->
                </div>

            </div>
            <!--<div class="row box mb3">

            </div>-->
        </div>
    </div>

</div>

{if isset($USER) == false}

    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">Esta acción requiere estar identificado</h4>
                </div>
                <div class="modal-body">
                    <a href="{$ROOT}login/login.php?returnURL={$returnURL}" class="btn btn-lg" id="login-btn"><img src="../images/meetup.png"> Entrar ahora</a>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
{/if}

{include file="footer.tpl"}
<script>
    require([
        'jquery',
        'profile'
    ],function($, profile){
        profile.init();
    });
</script>
</body>
</html>