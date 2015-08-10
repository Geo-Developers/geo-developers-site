<!DOCTYPE HTML>
<html>
	<head>
		{include file="header.tpl" title="Comunidad de Geo Developers"}
	</head>
	<body id="register-page">
		{include file="menu.tpl" title="Comunidad de Geo Developers"}

		<div class="container style1 wrapper">
			<div class="row">
			  <div class="col-xs-offset-4 col-md-4 ">
			  	<h1 class="mb1">
			  		Último paso
			  	</h1>
			  	<form action="." method="POST" class="box text-left">
			  		<div class="text-center"><img src="{{$USER["photo_url"]}}" alt="User photo" class="img-thumbnail" style="max-height: 80px;margin-bottom:1em"></div>
			  		<div class="form-group">
				  		<label for="email" class="control-label">Indícanos tu email:</label>
				  		<input type="email"  id="email" name="email" class="form-control" style="color:rgb(85, 85, 85);" autofocus  required="required">
					</div>

					<div class="form-group">
				  		<label for="name" class="control-label">Revisa que tu nombre esté correcto:</label>
				  		<input type="type" value="{{$USER["name"]}}" id="name" name="name" class="form-control"  required="required">
			  		</div>
                    <!-- TODO: Add last name input -->
			  		<input type="submit" value="Terminar" class="btn btn-primary btn-block" style="margin:0">

			  	</form>
			  </div>

			</div>
			</div>

		
	{include file="footer.tpl"}
</body>
</html>

