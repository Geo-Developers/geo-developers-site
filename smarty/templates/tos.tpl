<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="tos">
{include file="menu.tpl"}
<div id="main-wrapper">
    <div class="wrapper style1">
        <article class="container" id="top">
            <div class="row">
                <div class="12u 12u(mobile)">

                    <article id="activities">
                        <header>
                            <h2>Términos legales</h2>
                        </header>
                        <h3>Política de Privacidad</h3>
                        <p>
                            Este sitio web utiliza autentificación mediante el <a href="http://www.meetup.com/meetup_api/auth/">sistema OAuth 2 de Meetup.com</a>, por tanto al usar este método se deben haber aceptado previamente el <a href="http://www.meetup.com/es-ES/terms/">acuerdo de términos del servicio de Meetup</a>.  Esto implica que el usuario acepta que parte de los datos introducidos en Meetup.com queden almacenados en los servidores de dicha empresa que se encuentran localizados en Estados Unidos.
                        </p>
                        <p>
                            Por otro lado y dado que www.geodevelopers.org es una iniciativa promovida desde ESRI ESPAÑA SOLUCIONES GEOESPACIALES, S.L  (en adelante, ESRI ESPAÑA) la página web se encuentra alojada en servidores localizados en España. Al acceder a los contenidos que requieren autenticación de esta página el usuario manifiesta que acepta y entiende que los datos introducidos directamente en esta página web estarán sujetos a la <a href="http://www.esri.es/es/politica-de-privacidad/">política de privacidad de Esri España</a>.
                        </p>
                        <p>
                            Los datos facilitados a través de www.geodevelopers.org sólo serán tratados por Esri España en función del fin para el que hayan sido facilitados y no serán incorporados a ningún otro sistema ni cedido a terceros salvo expresa solicitud del usuario.
                        </p>

                        <h3>Política de Cookies</h3>
                        <p>El sitio utiliza cookies que generan estadísticas sobre la recurrencia de los visitantes, conocer las secciones que más interés despiertan, las interfaces más utilizadas, etc. con el objetivo de poder mejorar tanto el contenido del sitio como la interfaz del mismo.</p>
                    </article>


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