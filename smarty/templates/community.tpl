<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="community">
{include file="menu.tpl"}
<div id="main-wrapper">

        <article class="container" id="top">
            <div class="row">
              <div class="col-md-12 acenter">
                <h1>Interactúa con los miembros de la comunidad</h1>
              </div>
                <div class="col-md-6">
                  <div class="channel">
                    <h2 class="mt-0 mb-1 mt0"><a href="http://meetup.com/Geo-Developers" target="_blank">A través de Meetup</a></h2>
                    <!--<a href="/new/login/login.php?returnURL=/new/community/" class="btn btn-lg" id="login-btn"><img src="/new/images/meetup.png"> Meetup.com</a>-->
                    <img src="../images/meetup-screenshot.png" alt="Meetup">

                    <ul class="default">
                      <li>Infórmate, inscríbete y opina sobre los <a href="https://www.meetup.com/es-ES/Geo-Developers/?scroll=true">próximos eventos</a></li>
                      <li>Participa en la <a href="https://www.meetup.com/es-ES/Geo-Developers/messages/archive/">lista de correo</a>: <a href="mailto:Geo-Developers-list@meetup.com">Geo-Developers-list@meetup.com</a></li>
                      <li>Accede a <a href="https://www.meetup.com/es-ES/Geo-Developers/photos/">las fotos</a> de los eventos anteriores</li>
                      <li>Conoce más sobre <a href="https://www.meetup.com/es-ES/Geo-Developers/sponsors/">los patrocinadores</a> de la comunidad</li>
                      <li>Escríbe mensajes privados con otros miembros</li>
                      <li>Accede a <a href="https://www.meetup.com/es-ES/Geo-Developers/about/">la wiki</a> de la comunidad</li>
                      <li>etc.</a>
                    </ul>

                    <a href="http://meetup.com/Geo-Developers" target="_blank" class="btn btn-success btn-block btn-lg">meetup.com/Geo-Developers</a>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="channel">
                    <h2 class="mt-0 mb-1 mt0"><a href="https://docs.google.com/forms/d/e/1FAIpQLSd18XdM62wakhQCf1yZHbvFWLr2ztM-WN1PNDdI9Hr-hx2ElQ/viewform">A través de Slack</a></h2>
                    <img src="../images/slack-screenshot.png" alt="Slack">

                    <ul class="default">
                      <li>Canal #empleo: agregador de <a href="http://www.feedrinse.com/services/channel/?chanurl=591ec4383ef57f5100bb0a614c11de9c">ofertas a nivel nacional</a></li>
                      <li>Canal #vídeos: recopilación de video tutorailes de Youtube</li>
                      <li>Canal #rss-planet: agregador de noticias de diferentes blogs</li>
                      <!--<li>Canal #offtopic: para otros temas</li>-->
                      <li>Canal <a href="https://groups.diigo.com/group/geo-developers">#recursos</a>: tecnologías, tutoriales, datasets, etc.</li>
                      <li>Canal #aplicaciones: para compartir geo-aplicaciones interesantes</li>
                      <li>Canal #stackoverflow: <a href="http://www.feedrinse.com/services/channel/?chanurl=27a0aed944319b8b4759d4de512b18a2">dudas</a> relacionadas con geo-desarrollo</li>
                      <!--<li>Canal #charlas: canal para interactuar durante los webinars</li>-->
                      <li>etc.</a>
                    </ul>

                    <a href="https://docs.google.com/forms/d/e/1FAIpQLSd18XdM62wakhQCf1yZHbvFWLr2ztM-WN1PNDdI9Hr-hx2ElQ/viewform" target="_blank" class="btn btn-success btn-block btn-lg">geodev.slack.com</a>

                  </div>
                </div>
            </div>
        </article>

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
