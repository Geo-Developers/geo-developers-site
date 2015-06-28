<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Comunidad de Geo Developers"}
	</head>
	<body>
		{include file="menu.tpl" title="Comunidad de Geo Developers"}
<!-- Home -->
			<div class="wrapper style1 background-image">
				<article class="container" id="top">
					<div class="row">
						<div class="12u 12u(mobile) claim">
							
								<h1><strong>GeoDevelopers.org</strong></h1>
							
							<p>Comunidad abierta de profesionales del mundo de los SIG</p>
							<!--

							<p>Somos una <strong>comunidad abierta</strong> de profesionales que colaboramos para estar a la última de tecnologías geográficas.</p>
							<a href="#activities" class="button big scrolly">Descubre qué hacemos</a>-->
						</div>
					</div>
				</article>
			</div>		

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
									<a href="tutoriales" class="image featured"><img src="images/pic01.jpg" alt="" /></a>
									<h3><a href="tutoriales">Tutoriales</a></h3>
									<p>Estamos preparando y recopilando tutoriales sobre APIs, SDKs, etc.</p>
								</article>
							</div>
							<div class="4u 12u(mobile)">
								<article class="box style2">
									<a href="http://meetup.com/Geo-Developers/" target="_blank" class="image featured"><img src="images/pic02.jpg" alt="" /></a>
									<h3><a href="http://meetup.com/Geo-Developers/" target="_blank">Eventos en vivo</a></h3>
									<p>Organizamos seminarios online y presenciales mensualmente.</p>
								</article>
							</div>
							<div class="4u 12u(mobile)">
								<article class="box style2">
									<a href="academy" class="image featured"><img src="images/pic03.jpg" alt="" /></a>
									<h3><a href="academy">Generar contenidos</a></h3>
									<p>Recopilamos todos los materiales de los eventos en nuestra web.</p>
								</article>
							</div>
						</div>
						<div class="row">
							<div class="4u 12u(mobile)">
								<article class="box style2">
									<a href="miembros" class="image featured"><img src="images/pic04.jpg" alt="" /></a>
									<h3><a href="miembros">Bolsa de profesionales</a></h3>
									<p>Si buscas un desarrollador GIS o eres uno puedes inscribirte al directorio</p>
								</article>
							</div>
							<div class="4u 12u(mobile)">
								<article class="box style2">
									<a href="recursos" class="image featured"><img src="images/pic05.jpg" alt="" /></a>
									<h3><a href="recursos">Recursos</a></h3>
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
						</div>
					</div>
				</article>
			</div>
{include file="footer.tpl"}

<script>
	require(['common'], function(){
  	require([
			'skel.min',
			'skel-viewport.min',
			'util',
			'ie/respond.min',
			'main',
  	],function(skel,view,util,respond,main){
  		main.init();
  		
  	});
  });	
</script>


			
</body>
</html>