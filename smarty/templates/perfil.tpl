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
        <div class="col-md-12" style="margin-top: 70px;margin-bottom:20px">
            <a href="../../">Home</a> &gt; <a href="{$ROOT}miembros">Miembros</a> &gt; Perfil de {$USER["name"]}
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 box text-left" style="padding-top: 10px;">
            <h1>{$USER["name"]}</h1>
            <p><span class="text-label">Ubicación:</span> {$PROFILE["location"]}</p>
            <p><span class="text-label">Miembro desde:</span> {$PROFILE["joined"]}</p>
            <p><span class="text-label">Profesión:</span> {$PROFILE["occupation"]|default:'Desconocida'}</p>
            <p><span class="text-label">Cargo:</span> {$PROFILE["position"]|default:'Desconocido'}</p>
            <p><span class="text-label">Estudios:</span> {$PROFILE["studies"]|default:'Desconocidos'}</p>
            <p class="strong">Conocimientos e intereses:</p>
            <ul class="row">
                {for $I=0 to $NUMSKILLS}
                    <li class="col-md-4">
                        {$SKILLS[$I]["name"]}
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
            </ul>

        </div>
        <div class="col-md-3 col-md-offset-1">
            <div class="row box mb3">
                <img src="{$PROFILE["photo_url"]}">
                {$PROFILE["progress"]}%<br>
            </div>
            <div class="row box mb3">
                <ul>
                    {if $PROFILE["twitter_url"]}
                        <li><a href='{$PROFILE["twitter_url"]}'>Twitter</a></li>
                    {/if}
                    {if $PROFILE["linkedin_url"]}
                        <li><a href='{$PROFILE["linkedin_url"]}'>Linkedin</a></li>
                    {/if}
                    {if $PROFILE["github_url"]}
                        <li><a href='{$PROFILE["github_url"]}'>Github</a></li>
                    {/if}
                    {if $PROFILE["meetup_url"]}
                        <li><a href='{$PROFILE["meetup_url"]}'>Meetup</a></li>
                    {/if}
                    {if $PROFILE["facebook_url"]}
                        <li><a href='{$PROFILE["facebook_url"]}'>Facebook</a></li>
                    {/if}
                    {if $PROFILE["flickr_url"]}
                        <li><a href='{$PROFILE["flickr_url"]}'>Flickr</a></li>
                    {/if}
                </ul>
            </div>
        </div>
    </div>

</div>



{include file="footer.tpl"}
<script>
    require([
        'jquery'
        'resources'
    ],function($, resources){
        resources.init();
    });
</script>
</body>
</html>