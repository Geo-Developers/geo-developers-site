<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Comunidad de Geo Developers"}
	</head>
	<body id="subscription-ok">
		{include file="menu.tpl" title="Comunidad de Geo Developers"}

		<div class="wrapper style1">
			<article class="container" id="top">
				<div class="row">
					<div class="12u 12u(mobile)">

						<article id="activities">
							<header>
								<h2>
									Perfecto!, ahora configura tus preferencias
								</h2>
							</header>
							<p>Te hemos enviado un último email con un enlace en el que nos puedes indicarnos si quieres recibir todo tipo de recursos o no.</p>
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