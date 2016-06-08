<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="https://js.arcgis.com/4.0/esri/css/main.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
  <script src="//code.jquery.com/jquery-1.12.3.min.js"></script>
  
  <script src="http://geodevelopers.org/assets/js/jsrender.js"></script>


<!-- ************************ ArcGIS Libraries ************************ -->

  <link rel="stylesheet" href="https://js.arcgis.com/4.0/esri/css/main.css">
  <script src="https://js.arcgis.com/4.0/"></script>

<!-- ************************************************ -->


<!-- ***********BOOTSTRAP LIBRARIES******************* -->

  <!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<!-- **************************************** -->

	<style>
	  html, body, #viewDiv {
	    padding: 0;
	    margin: 0;
	  }
	  #viewDiv,
	  #main-wrapper,
	  #mapContainer {
	  	height: 100%;
	  }
	  #viewDiv{
	  	width: 100%;
	  }
	  
		.padding10{
		  padding: 10;
	    margin: 0;	
		}
		#miniViewDiv {
      position: absolute;
      right: 15px;
      width: 300px;
      height: 150px;
      bottom: 0px;
      border-top: 5px solid rgba(255, 255, 255, 0.65);
      border-left: 5px solid rgba(255, 255, 255, 0.65);
    }
	</style>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="tos">
	{include file="menu.tpl"}
	<div id="main-wrapper">
	<div id= "jobsDiv" class="col-md-4 padding10" >
		<div id="accordion" role="tablist" aria-multiselectable="true" ></div>
	</div>
	<div id="mapContainer" class="col-md-8">
		<div id="viewDiv"></div>
		<div id="miniViewDiv"></div>
	</div>

	<?php {literal} ?>
	<!-- HERE IS THE TEMPLATE TO GENERATE THE JOBS OFFERS ACCORDION -->
	<script id="theTmpl" type="text/x-jsrender">
	<div>
		  <div class="panel panel-default">
		    <div id="heading-{{:id}}" class="panel-heading" role="tab" >
		      <h4 class="panel-title">
		        <a id="link2Collapse-{{:id}}" data-toggle="collapse" data-parent="#accordion"  href="#collapse-{{:id}}" aria-expanded="true" aria-controls="collapseOne">
		          <h4>{{:title}}</h4>
		        </a>
		      </h4>
		    </div>
		    <div id="collapse-{{:id}}" class="panel-collapse collapse padding10" role="tabpanel" aria-labelledby="headingOne">
		    	<h5 class="text-primary" >Información de contacto</h5>
		    	<span class="text-primary">Empresa: </span>
		    	{{:company_name}}
		    	<br>
		    	<span class="text-primary">Email:  </span>
		    	{{:contact_email}}
		    	<br>
		    	<span class="text-primary">Otra información: </span>
		    	{{:contact_other}}
		    	<br>
		    	<h5 class="text-primary" >Detalles de la oferta</h5>
		    	<span class="text-primary">Tipo de contrato: </span>
		    	{{:contract_type}}
		    	<br>
		    	<span class="text-primary">Salario: </span>
		    	{{:salary_budget}}
		    	<br>
		    	<span class="text-primary">Detalles: </span>
		    	{{:offer_details}}
		    	<br>
		    	<br>
		    	<span class="text-primary">Localización: </span>
		    	{{:location}}
		    	<br>    	
		    </div>
	    </div>
	</div>
	</script>
	<?php {/literal} ?>

	<script>

	</script>

	<script>
	var view,simpsonView;
	var data = [];
	require([
	  "esri/Map",
	  "esri/WebMap",
	  "esri/views/MapView",
	  "esri/geometry/Point",
	  "esri/symbols/PictureMarkerSymbol",
	  "esri/Graphic",
	  "dojo/on",
	  "dojo/dom",
	  "dojo/domReady!"
	], function(Map,WebMap,MapView,Point,PictureMarkerSymbol,Graphic,on,dom){
	  var map = new Map({
	    basemap: "streets-night-vector"
	  });
		var simpsonsMap = new WebMap({
      portalItem: {
        id: "7f3b77c3833540e49ab3b9cf3644ee7b"
      }
    });	  
	  // view = new MapView({
	  //   container: "viewDiv",  
	  //   map: map,
	  //   zoom: 6, 
	  //   center: [-3, 40]
	  // });
	  createView ("viewDiv",map,6,[-3, 40]);
	  createView ("miniViewDiv",simpsonsMap,6,0);
	  // var simpsonView = new MapView({
   //    map: simpsonsMap,
   // 		zoom: 4,
   //    container: "miniViewDiv",
   //    center: 0
   //  });
  	var symbol = new PictureMarkerSymbol({
		  url: "https://webapps-cdn.esri.com/CDN/custom-pages/about/static/img/dist/animation/what-we-do-pin-lg.png",
		  width: 10,
		  height: 20,
		  yoffset: 7
		});

	  var highlightedsymbol = new PictureMarkerSymbol({
		  url: "http://desarrolladores.esri.es/wp-content/uploads/images/ArcGIS%20PIN%20ICON.png",
		  width: 10,
		  height: 20,
		  yoffset: 7
		});

	  view.then(drawPoints(), function(error){
	  	console.log("Imposible cargar el mapa:" + error);
		});

	  // *********************************
		// PETICION AJAX
		// *********************************
		var data = [];
		$.getJSON("http://www.geodevelopers.org/api/jobs?callback=?", function(datos){

			data = datos;
			drawPoints();
			// *********************************
			// RENDERIZE JOBS OBJET IN THE TEMPLATE
			// *********************************
			var template = $.templates("#theTmpl");
			var htmlOutput = template.render(data);
			$("#accordion").html(htmlOutput);

			// *********************************
			// BOOTSTRAP ACORDION FUNCTIONS
			//1.Highlight job location
			//2.GoTo Job location
			// *********************************		
			$('.collapse').on('show.bs.collapse', function (e) {
		  	view.graphics.removeAll();
		  	drawPoints();
		  	var divId = e.target.id;
		  	var idPt = divId.substring(9);
		  	console.log(idPt);
		  	var jobsGraphic = view.graphics._items;

		  	for (i = 0; i < jobsGraphic.length; i++) {
		  		if (idPt == jobsGraphic[i].attributes.id) {
		  			jobsGraphic[i].symbol = highlightedsymbol;
		  			view.goTo({
		  					target: jobsGraphic[i].geometry,
		  					zoom: 8
		  				},
		  				{
		  					animate: true,
  							duration: 1000,
  							easing: "ease-in-out"
						});
		  		}
		  	}
			});
		});


	  function drawPoints(){
			if (data && view) {
			  for (i = 0; i < data.length; i++) {
			  	var lat = data[i].location_lat;
			  	var long = data[i].location_lon;
			  	var jobID = data[i].id;
			    var point = new Point({
			 			longitude: long,
			      latitude: lat
			    });
			    var pointGraphic = new Graphic({
			      geometry: point,
			      symbol: symbol,
			      attributes: {
						  "id": jobID,
						}
			    });
			  	view.graphics.add(pointGraphic);
			  }
			}
		}


		// *********************************
		// Setting the viewdivs change
		// *********************************

		var miniViewDiv = dom.byId('miniViewDiv');
		on(miniViewDiv, "click",changeViews);

		function changeViews(){
			
			if (this.id === "miniViewDiv") {
			}else{

			}

		}

		function createView(viewId,mapToSet,zoomToApply,centerToSet){
			view = new MapView({
	    container: viewId,  
	    map: mapToSet,
	    zoom: zoomToApply, 
	    center: centerToSet
	  });
		}


	});


	</script>

	    {include file="footer.tpl"}
	</div>

	<script>
	    	
	</script>
</body>
</html>