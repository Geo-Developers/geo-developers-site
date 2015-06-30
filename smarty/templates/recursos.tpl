<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Comunidad de Geo Developers"}
	</head>
	<body>
		{include file="menu.tpl" title="Comunidad de Geo Developers"}

		<div class="wrapper style1">
			<article class="container" id="top">
				<div class="row">
					<div class="12u 12u(mobile)">

						<article id="activities">
							<header>
								<h2>Lista de correo</h2>
							</header>
							<p>Cualquiera puede unirse o consultar <a href="http://www.meetup.com/es/Geo-Developers/messages/archive/">la lista de correo</a> Geo-Developers-list@meetup.com (ya somos más de 400 personas) que utilizamos para hacer consultas, compartir información, etc.</p>
							<p>Debido al gran número de personas hemos establecido unas <a href="http://www.meetup.com/Geo-Developers/pages/Uso_de_la_lista_de_correo/">convenciones de uso y etiquetado</a>.</p>
						</article>

						<article id="activities">
							<header>
								<h2>Recursos</h2>
							</header>
							<p>Además de datos, también tenemos una <a href="http://www.meetup.com/Geo-Developers/about/">wiki</a> donde cualquier miembro puede colaborar añadiendo <a href="http://www.meetup.com/Geo-Developers/pages/Proyectos_e_ideas">ideas de aplicaciones</a>, <a href="http://www.meetup.com/Geo-Developers/pages/Datos/">enlaces a repositorios de datos</a>, etc.</p>
						</article>
						
						<article id="activities">
							<header>
								<h2>Juegos de datos (datasets)</h2>
							</header>
							<p>Utilizando <a href="https://groups.diigo.com/group/geo-developers/">Diigo</a> los miembros de la comunidad reunimos y etiquetamos enlaces a páginas que contienen datasets.</p>

							<p>Buscar por formato: 
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/csv">csv</a>,  
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/xls">xls</a>,  
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/xml">xml</a>,  
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/shapefile">shapefile</a>,  
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/gpx">gpx</a>,  
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/txt">txt</a>,  
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/kml">kml</a>,  
								<a href="https://groups.diigo.com/group/geo-developers/content/tag/ods">ods</a>. 
							</p>
						</article>
					</div>
				</div>
			</article>
		</div>
{include file="footer.tpl"}

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