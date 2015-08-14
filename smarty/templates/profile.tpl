<!DOCTYPE HTML>
<html>
<head>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="profile-{$ACTION}-page">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-top: 70px;margin-bottom:20px;padding-left: 0;">

            <a href="{$ROOT}">Home</a> &gt;
                <a href="{$ROOT}miembros">Miembros</a> &gt;
                {if $ACTION == "view"}
                    Perfil de {$PROFILE["name"]}
                {else}
                    <a href="{$ROOT}miembros/{$PROFILE["meetup_id"]}">Perfil de {$PROFILE["name"]}</a> &gt;
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
        profile.init();
    });
</script>
</body>
</html>