<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Comunidad de Geo Developers"}
	</head>
<body class="videoList">
		{include file="menu.tpl" title="Comunidad de Geo Developers"}
		<div class="container">
			<div class="row">
				<div class="col-md-12" style="margin-top: 70px;margin-bottom: 20px">
					<a href="../">Home</a> &gt; Academy
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row" id="videoList">
			{literal}
				<script id="videoTmpl" type="text/x-jsrender">
				{{for data}}
					<div class="4u 12u(mobile)">
						<article class="box style2">
							<a href="#" class="image featured" onclick=view("{{:id}}")><img src="https://i.ytimg.com/vi/{{:id}}/mqdefault.jpg" alt="" /></a>
							<div class="table">
								<p>{{:titulo}}</p>
							</div>
						</article>
					</div>
		    {{/for}}
		    </script>
    	{/literal}
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