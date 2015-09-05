<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="subscription">
{include file="menu.tpl"}
<div id="main-wrapper">
    <div class="wrapper style1">
        <article class="container" id="top">
            <div class="row">
                <div class="6u 12u(mobile)">

                    <article id="activities">
                        <header>
                            <h2 style="text-align: center;">Te hemos enviado un email</h2>
                        </header>
                        <p>Necesitamos que confirmes tu dirección de correo electrónico.</p>
                        <p>Para completar el proceso de suscripción, haz clic en el vínculo del mensaje que acabamos de enviarte.</p>
                    </article>

                </div>
                <div class="6u 12u(mobile)" style="text-align: center;padding-top:6em">
                    <img src="{$ROOT}images/thumb-up.gif">
                </div>
            </div>
        </article>
    </div>
    {include file="footer.tpl"}
</div>

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