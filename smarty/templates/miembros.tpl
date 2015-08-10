<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="members-page">
{include file="menu.tpl" title="Comunidad de Geo Developers"}

<div class="container">
    <div class="row">

        <div class="12u 12u(mobile)">
            <h1>{$TOTALUSERS} miembros</h1>
            <ul id="member-list">
                {for $I=0 to $NUMUSERS}

                    <li class="col-md-4" data-userid="{$USERS[$I]["id"]}">
                        {if isset($USERS[$I]["photo_url"])}
                            <div class="image-wrapper">
                                <div class="picture clearfix" style="background-image: url('{$USERS[$I]["photo_url"]}')">
                                </div>
                            </div>
                        {else}
                            Sin foto<br>
                        {/if}
                        <p><a href="{$USERS[$I]["id"]}">{$USERS[$I]["name"]}</a></p>
                        <p>{$USERS[$I]["location"]}</p>
                    </li>

                {/for}
            </ul>
        </div>
    </div>

</div>
{include file="footer.tpl"}
<script>
    require([
        'jquery',
        'academy',
        'bootstrap'
    ],function($, academy){
        academy.init("videos");
    });
</script>
</body>
</html>