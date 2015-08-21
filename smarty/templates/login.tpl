<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="login-page">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<div id="main-wrapper">
    <div class="container style1 wrapper">


        <div class="row">
            <div class="col-md-6 acenter">
                <h1 class="mb1">Identificación requerida</h1>
                <p><img src="../images/academy.png" class="thumbnail"></p>
                <p class="mt2">Para acceder a todos los vídeos sólo tienes que autenticarte con Meetup.</p>
            </div>
            <div class="col-md-6">

                <a href="login.php?returnURL={$returnURL}" class="btn btn-lg" id="login-btn"><img src="../images/meetup.png"> Entrar ahora</a>
            </div>
        </div>
    </div>
    {include file="footer.tpl"}
</div>

</body>
</html>