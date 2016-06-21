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
	  #footer{
	  	display: none;
	  }
	  #viewDiv,
	  #main-wrapper,
	  #mapContainer {
	  	height: 100%;
	  }
	  #viewDiv{
	  	position: absolute;
	  	/*position: fixed;*/
	  	width: 100%;
	  }
	  
		.padding10{
		  padding: 10;
	    margin: 0;	
		}
		#miniViewDiv {
      /*position: fixed;*/
      position: absolute;
      z-index: 1;
      right: 15px;
      width: 300px;
      height: 150px;
      bottom: 0px;
      border-top: 5px solid rgba(255, 255, 255, 0.65);
      border-left: 5px solid rgba(255, 255, 255, 0.65);
    }
    #chngViewBtn{
    	position: absolute;
    	z-index: 1;
    	top: 3px;
    	left: 3px;
    }

	</style>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="tos">
	{include file="menu.tpl"}
	<div id="main-wrapper">

		<!-- MODAL -->
		<div class="container">
		  <!-- Trigger the modal with a button -->
		  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Crear oferta</button>

		  <!-- Modal -->
		  <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title">Publicar oferta de trabajo</h4>
		        </div>
		        <div class="modal-body">

							<form role="form">
							  <div class="form-group">
							    <label for="inputTitle">Título de la oferta:</label>
							    <input type="email" class="form-control" id="inputTitle">
							    <hr>
							  
							  </div>
							  <h4>Información de contacto</h4>
							  <div class="form-group">
							    <label for="inputCompany">Empresa:</label>
							    <input type="password" class="form-control" id="inputCompany">
							  </div>
							  <div class="form-group">
							    <label for="inputEmail">Email:</label>
							    <input type="password" class="form-control" id="inputEmail">
							  </div>
							  <div class="form-group">
								  <label for="inputOtherInfo">Otra información:</label>
								  <textarea class="form-control" rows="5" id="inputOtherInfo"></textarea>
								</div>
								<hr>
							  <h4>Detalles de la oferta</h4>

							  <button type="submit" class="btn btn-default">Submit</button>
							</form>
		          <p>Some text in the modal.</p>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
		      </div>		      
		    </div>
		  </div>  
		</div>


		<!-- JOBS ACCORDION -->
		<div id= "jobsDiv" class="col-md-4 padding10" >
			<div id="accordion" role="tablist" aria-multiselectable="true" ></div>
		</div>
		<div id="mapContainer" class="col-md-8">
			<div id="viewDiv"></div>
			<div id="miniMapElements">
				<div id="miniViewDiv" simpsons-in-main-view="0" >
					<button id="chngViewBtn" type="button" class="btn btn-default btn-xs">
					  <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
					</button>	
				</div>
			</div>	
		</div>


	<?php {literal} ?>
	<!-- HERE IS THE TEMPLATE TO GENERATE THE JOBS OFFERS ACCORDION -->
	<script id="theTmpl" type="text/x-jsrender">
	<div>
		  <div class="panel panel-default">
		    <div id="heading-{{:id}}" class="panel-heading" role="tab" >
		      <h4 class="panel-title">
		        <a id="link2Collapse-{{:id}}"  data-toggle="collapse" data-parent="#accordion"  href="#collapse-{{:id}}" aria-expanded="true" aria-controls="collapseOne">
		          <h4>{{:title}}</h4>
		        </a>
		      </h4>
		    </div>
		    <div id="collapse-{{:id}}" job-id="{{:id}}" class="panel-collapse collapse padding10" role="tabpanel" aria-labelledby="headingOne">
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
		require([
		  "esri/Map",
		  "esri/WebMap",
		  "esri/views/MapView",
		  "esri/geometry/Point",
		  "esri/symbols/PictureMarkerSymbol",
		  "esri/Graphic",
		  "esri/PopupTemplate",
		  "dojo/on",
		  "dojo/dom",
		  "dojo/domReady!"
		], function(Map,WebMap,MapView,Point,PictureMarkerSymbol,Graphic,PopupTemplate,on,dom){
		  var map = new Map({
		    basemap: "streets-night-vector"
		  });
			var simpsonsMap = new WebMap({
	      portalItem: {
	        id: "9ac664557a774a858adee0edbb4f686c"
	      }
	    });

	    var worldView = createView ("viewDiv",map,5,[-3, 40],["zoom","attribution"]);	  
			var simpsonsView = createView ("miniViewDiv",simpsonsMap,6,0,["attribution"]);


		  // var symbol = createSymbol("https://raw.githubusercontent.com/Esri/quickstart-map-js/master/images/grey-pin-blank.png");
		  var symbol = createSymbol("/images/grey-pin-blank.png");
		  
		  var highlightedSymbol = createSymbol("/images/grey-pin-star.png");
			var symbolSips = createSymbol("/images/orange-pin-blank.png");
		  var highlightedSymbolSimps = createSymbol("/images/orange-pin-star.png");

		  {literal}
		  var template = new PopupTemplate({
        // title: "Marriage in NY, Zip Code: {ZIP}",
        // content: "<p>As of 2015, <b>{MARRIEDRATE}%</b> of the population in this zip code is married.</p>" +
        //   "<ul><li>{MARRIED_CY} people are married</li>" +
        //   "<li>{NEVMARR_CY} have never married</li>" +
        //   "<li>{DIVORCD_CY} are divorced</li><ul>"
        title: "{title}",

        
        	content:'<span class="text-primary">Localización: </span>\
		    	{location}\
		    	<br>\
        	<h5 class="text-primary" >Información de contacto</h5>\
		    	<span class="text-primary">Empresa: </span>\
		    	{company_name}\
		    	<br>\
		    	<span class="text-primary">Email:  </span>\
		    	{contact_email}\
		    	<br>\
		    	<h5 class="text-primary" >Detalles de la oferta</h5>\
		    	<span class="text-primary">Tipo de contrato: </span>\
		    	{contract_type}\
		    	<br>\
		    	<span class="text-primary">Salario: </span>\
		    	{salary_budget}\
		    	<br>\
		    	<br>'
      });

		  {/literal}


		  //Esto quitarlo?????
		  // !?!?!?!??!?!?!?!?
		  // checkViewsThenDraw();


 		  // *********************************
			// PETICION AJAX SIMPSONS POIS
			// *********************************

		  window.GEODEV.jobs = {};
			$.getJSON("/assets/data/simpsonsPOIs.json", function(datos){
				 GEODEV.jobs.simpsonsAllPOIs = datos.POIS;
				GEODEV.jobs.simpsonsPOIs = [];
				getRandomSimpsPOIs(datos.POIS);
				// drawPoints();

			});


				function getRandomSimpsPOIs() {
					if (GEODEV.jobs.data && GEODEV.jobs.simpsonsAllPOIs){
						var count = 0;
					  for (i = 0; i < GEODEV.jobs.data.length; i++) {
					  	if (GEODEV.jobs.data[i].on_remote === "yes") {
								var POIIndex = Math.floor(Math.random() * (54-count));
						    GEODEV.jobs.simpsonsPOIs[count] = GEODEV.jobs.simpsonsAllPOIs[POIIndex];
						    // GEODEV.jobs.simpsonsPOIs[count].y = GEODEV.jobs.simpsonsAllPOIs[POIIndex].geometry.y;
						    GEODEV.jobs.simpsonsAllPOIs.splice(POIIndex,1);
						    count++;
						  }
						}
						checkViewsThenDraw();
						// drawPoints();
					}
				}





		  // *********************************
			// PETICION AJAX JOBS DATA
			// *********************************

			// $.getJSON("http://www.geodevelopers.org/api/jobs?callback=?", function(datos){
			$.getJSON("/api/jobs?callback=?", function(datos){
				GEODEV.jobs.data = datos;
				getRandomSimpsPOIs();
				// *********************************
				// RENDERIZE JOBS OBJET IN THE TEMPLATE
				// *********************************
				var template = $.templates("#theTmpl");
				var htmlOutput = template.render(GEODEV.jobs.data);
				$("#accordion").html(htmlOutput);
				// *********************************
				// Setting the viewdivs change
				// *********************************
				var miniViewDiv = dom.byId('miniViewDiv');
				var chngViewBtn = dom.byId('chngViewBtn');
				on(chngViewBtn, "click",changeViews);




				// *********************************
				// BOOTSTRAP ACORDION FUNCTIONS
				//1.Highlight job location
				//2.GoTo Job location
				// *********************************	

				GEODEV.jobs.prevJobShow;

				$('.collapse').on('show.bs.collapse', function (e) {

			  	worldView.graphics.removeAll();
			  	simpsonsView.graphics.removeAll();
			  	drawPoints();
			  	//Collapse previous accordion opened
			  	$(GEODEV.jobs.prevJobShow).collapse('hide');
			  	
			  	var idJob = parseInt(e.target.getAttribute("job-id"));
			  	var simpsonsViewGraphic = simpsonsView.graphics.items;
			  	var worldViewGraphic = worldView.graphics.items;

			  	var isInWorldView = worldViewGraphic.find(isInView);
			  	var isInSimpsonsView = simpsonsViewGraphic.find(isInView);
			  	function isInView (lyr){
			  		return lyr.attributes.id=== idJob;
			  	}

			  	if (isInWorldView) {
			  		isInWorldView.symbol = highlightedSymbol;
	  				worldView.goTo({
		  					target: isInWorldView.geometry,
		  					zoom: 8
		  				},
		  				{
		  					animate: true,
  							duration: 1000,
  							easing: "ease-in-out"
						});

			  	} else {
			  		isInSimpsonsView.symbol = highlightedSymbolSimps;
	  				simpsonsView.goTo({
		  					target: isInSimpsonsView.geometry
		  				},
		  				{
		  					animate: true,
  							duration: 1000,
  							easing: "ease-in-out"
						});
			  	}

			  	//Getting the element to collapse when another accordion is been opened
			  	var prevJobShow = $("#" + e.target.getAttribute("id"));
			  	GEODEV.jobs.prevJobShow = prevJobShow[0];
			  	

				});
			});

			function createSymbol (url){
				return new PictureMarkerSymbol({
				  url: url,
				  // width: 15,
				  width: 60,
				  height: 65
				});
			}

			function checkViewsThenDraw () {
			  worldView.then(function(){ 	
			  	drawPoints();
			  }, function(error){
			  	console.log("Imposible cargar el mapa:" + error);
				});
				simpsonsView.then(function(){ 	
			  	drawPoints();
			  }, function(error){
			  	console.log("Imposible cargar el mapa:" + error);
				});	
		  }
			
		  function drawPoints(){
				if ( worldView.ready && simpsonsView.ready) {
					var count = 0;
				  for (i = 0; i < GEODEV.jobs.data.length; i++) {
				  	var jobID = GEODEV.jobs.data[i].id;
				  	var jobTitle = GEODEV.jobs.data[i].title;
				  	var jobCompany_name = GEODEV.jobs.data[i].company_name;
				  	var jobContact_email = GEODEV.jobs.data[i].contact_email;
				  	var jobContact_other = GEODEV.jobs.data[i].contact_other;
				  	var jobSalary_budget = GEODEV.jobs.data[i].salary_budget;
				  	var jobOffer_details = GEODEV.jobs.data[i].offer_details;
						var jobContract_type = GEODEV.jobs.data[i].contract_type;
						var jobLocation = GEODEV.jobs.data[i].location;

				  	var pointGraphic = new Graphic({
					      attributes: {
								  "id": jobID,
								  "title": jobTitle,
								  "company_name": jobCompany_name,
								  "contact_email": jobContact_email,
								  "contact_other": jobContact_other,
								  "salary_budget": jobSalary_budget,
								  "offer_details": jobOffer_details,
								  "contract_type": jobContract_type,
									"location": jobLocation
								}
					    });

				  		var point = new Point();

				    if (GEODEV.jobs.data[i].on_remote === "yes") {

					    var POICoordX = GEODEV.jobs.simpsonsPOIs[count].geometry.x;	
					    var POICoordY = GEODEV.jobs.simpsonsPOIs[count].geometry.y;
					    var POIname = GEODEV.jobs.simpsonsPOIs[count].attributes.Name;
					    count++;
					    point.longitude = POICoordX;
					    point.latitude = POICoordY;


					    pointGraphic.geometry = point;
					    pointGraphic.symbol = symbolSips;
					    pointGraphic.attributes.location = POIname;

						    if (simpsonsView.container.id === "viewDiv") {
						    	pointGraphic.popupTemplate = template;	
						    }
					    simpsonsView.graphics.add(pointGraphic);	
					  }else	{
					  	var lat = GEODEV.jobs.data[i].location_lat;
				  		var long = GEODEV.jobs.data[i].location_lon;

				  		point.longitude = long;
					    point.latitude = lat;


					    pointGraphic.geometry = point;
					    pointGraphic.symbol = symbol;

					    if (worldView.container.id === "viewDiv") {
						   	pointGraphic.popupTemplate = template;	
						  }
					  	worldView.graphics.add(pointGraphic);
					  }
				  }
				} else{
					console.log('No estan ready las views aun');
				}
			}

			function changeViews(callback){
				if (miniViewDiv.getAttribute("simpsons-in-main-view") === "0") {
					worldView = createView ("miniViewDiv",map,6,[-3, 40],["attribution"]);
		  		simpsonsView = createView ("viewDiv",simpsonsMap,6,0,["zoom","attribution"]);
		  		checkViewsThenDraw();
		  		miniViewDiv.setAttribute("simpsons-in-main-view","1");

				}else{
					worldView = createView ("viewDiv",map,6,[-3, 40],["zoom","attribution"]);
		  		simpsonsView = createView ("miniViewDiv",simpsonsMap,6,0,["attribution"]);
		  		checkViewsThenDraw();
		  		miniViewDiv.setAttribute("simpsons-in-main-view","0");
				}
			}

			function createView(viewId,mapToSet,zoomToApply,centerToSet,uiArray){
				return new MapView({
			    container: viewId,  
			    map: mapToSet,
			    zoom: zoomToApply, 
			    center: centerToSet,
			    ui: {
			    	components: uiArray 
			    }
			  });
			}

		});
	</script>

	    {include file="footer.tpl"}
	</div>

</body>
</html>