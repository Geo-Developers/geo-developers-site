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
            <a href="../../">Home</a> &gt; <a href="{$ROOT}miembros">Miembros</a> &gt; Perfil de {$USERPROFILE["name"]}
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 box text-left" style="padding-top: 10px;position: relative">
            <div id="progress" style="position: absolute;top:30px;right:20px">
                <img src="{$PROFILE["photo_url"]}">
                <a href="" class="btn btn-danger btn-block mt1">Contactar</a>
            </div>

            <h1>{$USERPROFILE["name"]}</h1>
            <p><span class="text-label">Ubicación:</span> {$PROFILE["location"]}</p>
            <p><span class="text-label">Miembro desde:</span> {$PROFILE["joined"]}</p>
            <p><span class="text-label">Bio:</span> {$PROFILE["bio"]|default:'No disponible'}</p>
            <p><span class="text-label">Profesión:</span> {$PROFILE["occupation"]|default:'Desconocida'}</p>
            <p><span class="text-label">Cargo:</span> {$PROFILE["position"]|default:'Desconocido'}</p>
            <p><span class="text-label">Estudios:</span> {$PROFILE["studies"]|default:'Desconocidos'}</p>
            <div><span class="text-label">Perfiles sociales:</span>
                <ul class="inline">
                    {if $PROFILE["twitter_url"]}
                        <li>
                            <a href='{$PROFILE["twitter_url"]}' class="icon fa-twitter">
                                <span class="label">Twitter</span>
                            </a>
                        </li>
                    {/if}
                    {if $PROFILE["linkedin_url"]}
                        <li>
                            <a href='{$PROFILE["linkedin_url"]}' class="icon fa-linkedin">
                                <span class="label">Linkedin</span>
                            </a>
                        </li>
                    {/if}
                    {if $PROFILE["github_url"]}
                        <li>
                            <a href='{$PROFILE["github_url"]}' class="icon fa-github">
                                <span class="label">Github</span>
                            </a>
                        </li>
                    {/if}
                    {if $PROFILE["meetup_url"]}
                        <li>

                            <a href='{$PROFILE["meetup_url"]}' class="icon fa-meetup">
                                <i class="icon-meetup">&nbsp;</i>
                                <span class="label">Meetup</span>
                            </a>
                        </li>
                    {/if}
                    {if $PROFILE["facebook_url"]}
                        <li>
                            <a href='{$PROFILE["facebook_url"]}' class="icon fa-facebook">
                                <span class="label">Facebook</span>
                            </a>
                        </li>
                    {/if}
                    {if $PROFILE["flickr_url"]}
                        <li>
                            <a href='{$PROFILE["flickr_url"]}' class="icon fa-flickr">
                                <span class="label">Flickr</span>
                            </a>
                        </li>
                    {/if}
                </ul>
            </div>
            <hr class="clearfix">

            <h2>Conocimientos e intereses:</h2>
            <p class="strong mt2 uppercase">Relacionados con el GeoDesarrollo:</p>
            {if $NUMSKILLSGIS == 0}
                <p>No se ha especificado ninguno</p>
            {else}
                <ul class="row">
                    {for $I=0 to $NUMSKILLSGIS-1}
                        <li class="col-md-4">
                            <span class="truncate" title="{$SKILLSGIS[$I]["name"]}">{$SKILLSGIS[$I]["name"]}</span>
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

            <p class="strong mt2 uppercase">Otros:</p>
            <ul class="row">
                {if $NUMSKILLS == 0}
                <p>No se ha especificado ninguno</p>
                {else}
                    {for $I=0 to $NUMSKILLS-1}
                        <li class="col-md-4">
                            <span class="truncate" title="{$SKILLS[$I]["name"]}">{$SKILLS[$I]["name"]}</span>
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
                <div id="donut_single" style="width: 180px; height: 180px;padding:0;margin: 0 45px 15px;"></div>
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
                <p><small>¿Eres tú?, puedes <a href="#">completarlo ahora</a></small></p>

                <!--{$PROFILE["progress"]}%<br>-->

            </div>
            <!--<div class="row box mb3">

            </div>-->
        </div>
    </div>

</div>



{include file="footer.tpl"}
<script>
    require([
        'jquery',
        'resources'
    ],function($, resources){
        resources.init();
    });
</script>
</body>
</html>