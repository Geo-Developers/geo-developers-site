<!DOCTYPE HTML>
<html>
<head>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    {include file="header.tpl" title="Perfil de {$PROFILE["name"]} {$PROFILE["last_name"]} en Geo Developers"}
    <meta name="description" content="{if isset({$PROFILE["bio"]})}{$PROFILE["bio"]|default:'Descubre sus conocimientos y habilidades.'}{/if}" />
</head>
<body id="profile-{$ACTION}">
{include file="menu.tpl"}
<div id="main-wrapper">
<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-bottom:20px;padding-left: 0;">

            <a href="{$ROOT}">Home</a> &gt;
                <a href="{$ROOT}members">Miembros</a> &gt;
                {if $ACTION == "view"}
                    Perfil de {$PROFILE["name"]}
                {else}
                    <a href="{$ROOT}members/{$PROFILE["meetup_id"]}">Perfil de {$PROFILE["name"]} {$PROFILE["last_name"]}</a> &gt;
                        Editar
                {/if}
        </div>
    </div>
    <div class="row">
        <div class="col-md-8 box text-left" style="padding-top: 10px;position: relative">
            {if $ACTION == "view"}
                {include file="profile/profile-view.tpl"}
            {else}
                {include file="profile/profile-edit.tpl"}
            {/if}
        </div>
        <div class="col-md-3 col-md-offset-1">
            {include file="profile/progress.tpl"}
            {include file="profile/recommend.tpl"}
        </div>
    </div>

</div>
{include file="blocks/modal-login.tpl"}


{include file="footer.tpl"}
<script>
    require([
        'jquery',
        'profile'
    ],function($, profile){
        profile.init("{$ACTION}");
    });
</script>
    </div>
</body>
</html>