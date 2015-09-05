<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="home">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<!-- Home -->
<div id="main-wrapper">
<div class="wrapper style1 background-image">
    <article class="container" id="top">
        <div class="row">
            <div class="12u 12u(mobile) claim">

                <h1><strong>GeoDevelopers.org</strong></h1>

                <p>
                    La comunidad de profesionales del mundo de los <a href="https://es.wikipedia.org/wiki/Sistema_de_informaci%C3%B3n_geogr%C3%A1fica" target="_blank">SIG</a>
                    <button class="btn btn-success btn-lg mt1 block" data-toggle="modal" data-target="#video">VER VÍDEO DE PRESENTACIÓN</button>
                </p>

                <!--

                <p>Somos una <strong>comunidad abierta</strong> de profesionales que colaboramos para estar a la última de tecnologías geográficas.</p>
                <a href="#activities" class="button big scrolly">Descubre qué hacemos</a>-->
            </div>
        </div>
    </article>
</div>
<!--<script>alert("Esta página está aún en fase alpha (desarrollo), debido a esto, no recomendamos rellenar los perfiles aún ya que algunos datos se podrían perder.");</script>-->
<!-- Portfolio -->
<div class="wrapper style3">
    <article id="activities">
        <header>
            <h2>Qué hacemos</h2>
        </header>
        <div class="container">
            <div class="row">
                <div class="4u 12u(mobile)">
                    <article class="box style2">
                        <a href="http://meetup.com/Geo-Developers/" target="_blank" class="image featured"><img src="images/pic02.jpg" alt="" /></a>
                        <h3><a href="http://meetup.com/Geo-Developers/" target="_blank">Eventos</a></h3>
                        <p>Organizamos seminarios online y presenciales mensualmente.</p>
                    </article>
                </div>
                <div class="4u 12u(mobile)">
                    <article class="box style2">
                        <a href="{$ROOT}academy" class="image featured"><img src="images/pic03.jpg" alt="" /></a>
                        <h3><a href="{$ROOT}academy">Generar contenidos</a></h3>
                        <p>Recopilamos todos los vídeos y transparencias en nuestra web.</p>
                    </article>
                </div>
                <div class="4u 12u(mobile)">
                    <article class="box style2">
                        <a href="{$ROOT}miembros" class="image featured"><img src="images/pic04.jpg" alt="" /></a>
                        <h3><a href="{$ROOT}miembros">Directorio</a></h3>
                        <p>Si buscas un desarrollador GIS o eres uno puedes consultarla o inscribirte</p>
                    </article>
                </div>
            </div>
            <!--<div class="row">

                <div class="4u 12u(mobile)">
                    <article class="box style2">
                        <a href="{$ROOT}tutoriales" class="image featured"><img src="images/pic01.jpg" alt="" /></a>
                        <h3><a href="{$ROOT}tutoriales">Tutoriales</a></h3>
                        <p>Estamos preparando y recopilando tutoriales sobre APIs, SDKs, etc.</p>
                    </article>
                </div>
                <div class="4u 12u(mobile)">
                    <article class="box style2">
                        <a href="{$ROOT}recursos" class="image featured"><img src="images/pic05.jpg" alt="" /></a>
                        <h3><a href="{$ROOT}recursos">Recursos</a></h3>
                        <p>Recopilaciones de juegos de datos, códigos reutilizables, etc.</p>
                    </article>
                </div>
                <div class="4u 12u(mobile)">
                    <article class="box style2">
                        <a href="https://github.com/Geo-Developers" class="image featured"><img src="images/pic06.jpg" alt="" /></a>
                        <h3><a href="https://github.com/Geo-Developers">Proyectos</a></h3>
                        <p>Puedes proponer o unirte a cualquier proyecto Open Source realizado.</p>
                    </article>
                </div>
            </div>-->
        </div>
    </article>
</div>

<div class="modal fade" id="video" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <!--<div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Valorar</h4>
            </div>-->
            <div class="modal-body text-center">

                    <iframe width="420" height="310" style="height:310px !important"src="https://www.youtube.com/embed/lXdkN5WgZ28" frameborder="0" allowfullscreen></iframe>

            </div>
            <!--<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>-->
        </div>
    </div>
</div>

{include file="footer.tpl"}

<script>
    require(['common'], function(){
        require([
            'main',
            'jquery'
        ],function(main,$){
            main.init();

        });
    });
</script>
</div>
</body>
</html>