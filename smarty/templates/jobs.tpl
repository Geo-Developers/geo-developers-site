<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
	  <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <meta name="viewport" content="width=device-width, initial-scale=1">


	  <?php {literal} ?>
	  <script>
		var _rollbarConfig = {
	    accessToken: "bd8336286d3e497bb5e3a28c9788bcbf",
	    captureUncaught: true,
	    captureUnhandledRejections: false,
	    payload: {
	        environment: "staging"
	    }
		};
		// Rollbar Snippet
		!function(r){function e(t){if(o[t])return o[t].exports;var n=o[t]={exports:{},id:t,loaded:!1};return r[t].call(n.exports,n,n.exports,e),n.loaded=!0,n.exports}var o={};return e.m=r,e.c=o,e.p="",e(0)}([function(r,e,o){"use strict";var t=o(1).Rollbar,n=o(2);_rollbarConfig.rollbarJsUrl=_rollbarConfig.rollbarJsUrl||"https://d37gvrvc0wt4s1.cloudfront.net/js/v1.9/rollbar.min.js";var a=t.init(window,_rollbarConfig),i=n(a,_rollbarConfig);a.loadFull(window,document,!_rollbarConfig.async,_rollbarConfig,i)},function(r,e){"use strict";function o(r){return function(){try{return r.apply(this,arguments)}catch(e){try{console.error("[Rollbar]: Internal error",e)}catch(o){}}}}function t(r,e,o){window._rollbarWrappedError&&(o[4]||(o[4]=window._rollbarWrappedError),o[5]||(o[5]=window._rollbarWrappedError._rollbarContext),window._rollbarWrappedError=null),r.uncaughtError.apply(r,o),e&&e.apply(window,o)}function n(r){var e=function(){var e=Array.prototype.slice.call(arguments,0);t(r,r._rollbarOldOnError,e)};return e.belongsToShim=!0,e}function a(r){this.shimId=++c,this.notifier=null,this.parentShim=r,this._rollbarOldOnError=null}function i(r){var e=a;return o(function(){if(this.notifier)return this.notifier[r].apply(this.notifier,arguments);var o=this,t="scope"===r;t&&(o=new e(this));var n=Array.prototype.slice.call(arguments,0),a={shim:o,method:r,args:n,ts:new Date};return window._rollbarShimQueue.push(a),t?o:void 0})}function l(r,e){if(e.hasOwnProperty&&e.hasOwnProperty("addEventListener")){var o=e.addEventListener;e.addEventListener=function(e,t,n){o.call(this,e,r.wrap(t),n)};var t=e.removeEventListener;e.removeEventListener=function(r,e,o){t.call(this,r,e&&e._wrapped?e._wrapped:e,o)}}}var c=0;a.init=function(r,e){var t=e.globalAlias||"Rollbar";if("object"==typeof r[t])return r[t];r._rollbarShimQueue=[],r._rollbarWrappedError=null,e=e||{};var i=new a;return o(function(){if(i.configure(e),e.captureUncaught){i._rollbarOldOnError=r.onerror,r.onerror=n(i);var o,a,c="EventTarget,Window,Node,ApplicationCache,AudioTrackList,ChannelMergerNode,CryptoOperation,EventSource,FileReader,HTMLUnknownElement,IDBDatabase,IDBRequest,IDBTransaction,KeyOperation,MediaController,MessagePort,ModalWindow,Notification,SVGElementInstance,Screen,TextTrack,TextTrackCue,TextTrackList,WebSocket,WebSocketWorker,Worker,XMLHttpRequest,XMLHttpRequestEventTarget,XMLHttpRequestUpload".split(",");for(o=0;o<c.length;++o)a=c[o],r[a]&&r[a].prototype&&l(i,r[a].prototype)}return e.captureUnhandledRejections&&(i._unhandledRejectionHandler=function(r){var e=r.reason,o=r.promise,t=r.detail;!e&&t&&(e=t.reason,o=t.promise),i.unhandledRejection(e,o)},r.addEventListener("unhandledrejection",i._unhandledRejectionHandler)),r[t]=i,i})()},a.prototype.loadFull=function(r,e,t,n,a){var i=function(){var e;if(void 0===r._rollbarPayloadQueue){var o,t,n,i;for(e=new Error("rollbar.js did not load");o=r._rollbarShimQueue.shift();)for(n=o.args,i=0;i<n.length;++i)if(t=n[i],"function"==typeof t){t(e);break}}"function"==typeof a&&a(e)},l=!1,c=e.createElement("script"),d=e.getElementsByTagName("script")[0],p=d.parentNode;c.crossOrigin="",c.src=n.rollbarJsUrl,c.async=!t,c.onload=c.onreadystatechange=o(function(){if(!(l||this.readyState&&"loaded"!==this.readyState&&"complete"!==this.readyState)){c.onload=c.onreadystatechange=null;try{p.removeChild(c)}catch(r){}l=!0,i()}}),p.insertBefore(c,d)},a.prototype.wrap=function(r,e){try{var o;if(o="function"==typeof e?e:function(){return e||{}},"function"!=typeof r)return r;if(r._isWrap)return r;if(!r._wrapped){r._wrapped=function(){try{return r.apply(this,arguments)}catch(e){throw e._rollbarContext=o()||{},e._rollbarContext._wrappedSource=r.toString(),window._rollbarWrappedError=e,e}},r._wrapped._isWrap=!0;for(var t in r)r.hasOwnProperty(t)&&(r._wrapped[t]=r[t])}return r._wrapped}catch(n){return r}};for(var d="log,debug,info,warn,warning,error,critical,global,configure,scope,uncaughtError,unhandledRejection".split(","),p=0;p<d.length;++p)a.prototype[d[p]]=i(d[p]);r.exports={Rollbar:a,_rollbarWindowOnError:t}},function(r,e){"use strict";r.exports=function(r,e){return function(o){if(!o&&!window._rollbarInitialized){var t=window.RollbarNotifier,n=e||{},a=n.globalAlias||"Rollbar",i=window.Rollbar.init(n,r);i._processShimQueue(window._rollbarShimQueue||[]),window[a]=i,window._rollbarInitialized=!0,t.processPayloads()}}}}]);
		// End Rollbar Snippet
		</script>
		<?php {/literal} ?>

		<!-- boostrap, ArcGIS and bootstrap-map CSS -->
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet" media="screen">
		<link rel="stylesheet" href="https://js.arcgis.com/4.0/esri/css/main.css">
		<link rel="stylesheet" type="text/css" href="http://esri.github.io/bootstrap-map-js/src/css/bootstrapmap.css">


	  <!-- ArcGIS,JQuery, Bootstrap, JSrender, typeahead+bloodhound JS -->
	  <!--<script src="https://js.arcgis.com/4.0/"></script>
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	  <script src="http://geodevelopers.org/assets/js/jsrender.js"></script>
	  <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.10.4/typeahead.bundle.min.js"></script>-->

	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		<script src="http://geodevelopers.org/assets/js/jsrender.js"></script>
		<script src="https://js.arcgis.com/4.0/"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/typeahead.js/0.10.4/typeahead.bundle.min.js"></script>




		<style>
		  html, body, #viewDiv {
		    padding: 0;
		    margin: 0;
		  }
		  #viewLocDiv {
	      padding: 0;
	      margin: 0;
	      height: 390px;
	      width: 100%;
	      position: relative;
	    }
		  #footer{
		  	/*display: none;*/
		  }
		  #viewDiv{
		  	position: relative;
		  	width: 100%;
		  	height: 500px;
		  }

			#miniViewDiv {
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
	    .tt-dropdown-menu {
	      background-color: #FFFFFF;
	      border: 1px solid rgba(0, 0, 0, 0.2);
	      border-radius: 8px 8px 8px 8px;
	      box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	      margin-top: 12px;
	      padding: 8px 0;
	      width: 422px;
	    }

			#createJobBtn{
		    z-index: 999;
		    top: 0;
		    display: block;
		    width: 100%;
		    border-radius: 0;
		    margin-bottom: 10px;
		    margin-top: -18px;
			}
	    form{
	    	display: none;
	    }
	    #jobsDiv{
  	    height: 500px;
		    overflow: auto;
		    border: 1px dotted #ccc;
		    padding: 1em;
	    }
		</style>
	    {include file="header.tpl" title="Comunidad de Geo Developers"}
	</head>

	<body id="jobs">
		<div id="main-wrapper">
			{include file="menu.tpl"}
			<button type="button" class="btn btn-primary btn-block toggle" href="#form" id="createJobBtn">Crear oferta</button>
			<!-- Form -->
			<div class="container">
				<form method="POST" action="../api/jobs" id="form" class="well">
					<div class="row">
						<div class="col-md-4">
							<h4>Información de la oferta</h4>
						  <div class="form-group">
						    <label class="text-primary" for="inputTitle">Título de la oferta</label>
						    <input type="text" class="form-control" name="inputTitle" id="inputTitle" required="true">
						  </div>
							<div class="form-group">
						    <label  class="text-primary" for="inputCompany">Empresa</label>
						    <input type="text" class="typeahead form-control" name="inputCompany" id="inputCompany" required="true">
						  </div>
						  <div class="form-group">
						    <label class="text-primary" for="inputEmail">Email</label>
						    <input type="email" class="form-control" name="inputEmail" id="inputEmail" required="true">
						  </div>
						  <div class="form-group">
							  <label class="text-primary" for="inputOtherInfo">Otra información de contacto</label>
							  <textarea class="form-control" rows="5" name="inputOtherInfo" id="inputOtherInfo"></textarea>
							</div>
						</div>
						<div class="col-md-4">
							<h4>Detalles de la oferta</h4>
						  <div class="form-group">
							  <label class="text-primary" for="selOnRemote">Tipo de trabajo</label>
							  <select class="form-control" name="selOnRemote" id="selOnRemote">
							    <option value="no">Presencial</option>
							    <option value="yes">Teletrabajo</option>
							    <option value="negociate">Negociable</option>
							  </select>
							</div>
							<div class="form-group">
							  <label class="text-primary" for="selContract">Tipo de contrato</label>
							  <select class="form-control" name="selContract" id="selContract">
							    <option value="Indefinido">Indefinido</option>
							    <option value="Obra y servico">Obra y servico</option>
							    <option value="Otro">Otro</option>
							  </select>
							</div>
							<div class="form-group">
						    <label class="text-primary" for="inputSalary">Salario</label>
						    <input type="text" class="form-control" name="inputSalary" id="inputSalary">
						  </div>
						  <div class="form-group">
							  <label class="text-primary" for="inputDetails">Detalles</label>
							  <textarea class="form-control" rows="5" name="inputDetails" id="inputDetails" required="true"></textarea>
							</div>
						</div>
						<div class="col-md-4" id="inputAddressCol">
			  			<h4>Localización</h4>
			  			<div class="form-group" id="inputAddressDiv">
			  				<p style="color: red;" id ="warningMsng"></p>
								<div id="viewLocDiv"></div>
								<input type="hidden" class="form-control" type="number" name="inputLong" id="inputLong">
			  				<input type="hidden" class="form-control" type="number" name="inputLat" id="inputLat">
			  				<input type="hidden" class="form-control" name="inputAddress" id="inputAddress">
						  </div>
			  		</div>
					</div>
					<div class="row">
			  		<div class="col-md-12">
			  			<button type="submit" class="btn btn-default" href="#form" id="sendBtnId">Enviar</button>
				      <button type="button" class="btn btn-default toggle" href="#form" >Cerrar</button>
			  		</div>
			  	</div>
				</form>
			</div>
			<!-- Show form -->
			<div class="container mt1">
				
				<div class="row">
				<!-- JOBS ACCORDION -->
					<div class="col-md-6 col-sm-6 col-xs-12" >
						<div  id= "jobsDiv">
							<div id="accordion" role="tablist" aria-multiselectable="true" ></div>
						</div>
					</div>
					<!-- MapsViews -->
					<div id="mapContainer" class="col-md-6 col-sm-6 hidden-xs">
						<div id="viewDiv"></div>
						<div id="miniMapElements">
							<div id="miniViewDiv" simpsons-in-main-view="0" >
								<button id="chngViewBtn" type="button" class="btn btn-default btn-xs">
								  <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Template to generate offers -->
			<?php {literal} ?>
				<script id="theTmpl" type="text/x-jsrender">
					<div>
					  <div class="panel panel-default">
					    <div id="heading-{{:id}}" class="panel-heading" role="tab" >
					      <h4 class="panel-title">
					        <a id="link2Collapse-{{:id}}"  data-toggle="collapse" data-parent="#accordion"  href="#collapse-{{:id}}" aria-expanded="true" aria-controls="collapseOne">
					          <h3 class="mt0">{{:title}}</h3>
					          <span class="text-primary">Fecha de publicación: </span>{{:date}} | 
					          <span class="text-primary">Salario: </span>
								    {{if salary_budget}}
								    	{{:salary_budget}} €
								    {{else}}
								    	Negociable
							    	{{/if}}

					        </a>
					      </h4>
					    </div>
					    <div id="collapse-{{:id}}" job-id="{{:id}}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
					    	<h5 class="text-primary" >Detalles de la oferta</h5>
					    	<span class="text-primary">Tipo de contrato: </span>
					    	{{:contract_type}}
					    	<br>
					    	
						    <span class="text-primary">Salario: </span>
						    {{if salary_budget}}
						    	{{:salary_budget}}
						    {{else}}
						    	Negociable
					    	{{/if}}
					    	<br>
					    	<span class="text-primary">Detalles: </span>
					    	{{:offer_details}}
					    	<br>
					    	<span class="text-primary">Localización: </span>
					    	
					    	{{if location}}
						    	{{:location}}
						    {{else}}
						    	En remoto
					    	{{/if}}
					    	<br><br>
					    	<h5 class="text-primary" >Información de contacto</h5>
					    	<span class="text-primary">Empresa: </span>
					    	{{:company_name}}
					    	<br>
					    	<span class="text-primary">Email:  </span>
					    	{{:contact_email}}
					    	<br>
					    	<span class="text-primary">Más información: </span>
					    	{{:contact_other}}
					    	<br>
					    </div>
				    </div>
					</div>
				</script>
			<?php {/literal} ?>
			<?php {literal} ?>
			<script>
				var places;
				require([
				  "esri/Map",
				  "esri/WebMap",
				  "esri/views/MapView",
				  "esri/geometry/Point",
				  "esri/symbols/PictureMarkerSymbol",
				  "esri/Graphic",
				  "esri/PopupTemplate",
				  "esri/tasks/Locator",
				  "esri/widgets/Search",
				  "dojo/on",
				  "dojo/dom",
				  "dojo/domReady!"
				], function(Map,WebMap,MapView,Point,PictureMarkerSymbol,Graphic,PopupTemplate,Locator,Search,on,dom){

					try{

				 // try{
							var map = new Map({
					    basemap: "streets-night-vector"
					  });
						// }catch(e){
						// 	Rollbar.error("error al cargar el mapa: ", e);
						// 	console.log("error al cargar el mapa: " + e + ". Refrescando página....");
						// 	location.reload();
						// }
						var simpsonsMap = new WebMap({
				      portalItem: {
				        id: "9ac664557a774a858adee0edbb4f686c"
				      }
				    });
				    var worldView = createView ("viewDiv",map,5,[-3, 40],["zoom","attribution"]);
						var simpsonsView = createView ("miniViewDiv",simpsonsMap,6,0,["attribution"]);

					  var symbol = createSymbol("/images/grey-pin-blank.png");
					  var highlightedSymbol = createSymbol("/images/grey-pin-star.png");
						var symbolSips = createSymbol("/images/orange-pin-blank.png");
					  var highlightedSymbolSimps = createSymbol("/images/orange-pin-star.png");


					  var template = new PopupTemplate({
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

					  //******************+
					  //*									*
					  //* FORM STUFF CODE *
					  //* 								*
						//*******************

						//show-hide form
						$('.toggle').click(function(){
								var target = $(this).attr('href');
				        $(target).toggle(500);
				        $(target)[0].reset();
						});

						//Autocomplete comapy name
						var companies = new Bloodhound({
			        datumTokenizer: function(datum) {
			          return Bloodhound.tokenizers.whitespace(datum.value);
			        },
			        queryTokenizer: Bloodhound.tokenizers.whitespace,
			        remote: {
			          url: 'https://autocomplete.clearbit.com/v1/companies/suggest?query=%QUERY',
			          filter: function(companies) {
			            // Map the remote source JSON array to a JavaScript object array
			            return $.map(companies, function(company) {
			              return {
			                value: company.name
			              };
			            });
			          }
			        }
			      });
			      // Initialize the Bloodhound suggestion engine
			      companies.initialize();
			      // Instantiate the Typeahead UI
			      $('.typeahead').typeahead(null, {
			        displayKey: 'value',
			        source: companies.ttAdapter()
			      });


			      //Creating map to locate views:
			      //****************************
			      var companyLocatMap = new Map({
			        basemap: "dark-gray"
			      });
			      var companyLocatView = createView ("viewLocDiv",companyLocatMap,5,[-3, 40]);
			      //Set the view global access to allow the form to call the localion coordinates from map to send it as a form
						companyLocatView.then(function(){
							GEODEV.jobs.companyLocatView = companyLocatView;
						});
			      //create widget
			      var searchWidget = new Search({
			        view: companyLocatView
			      });
			      //Change widget icon
			      searchWidget.sources.items[0].resultSymbol = highlightedSymbol;
			      //start widget
			      searchWidget.startup();
			      // On start serach clear graphics and get the address
			      searchWidget.viewModel.on("search-start", function(evt){
			        companyLocatView.graphics.removeAll();
			        evt.target.popupOpenOnSelect = false;
			        GEODEV.jobs.address = evt.target.currentSuggestion.text;
			      });
			      //add widget to the UI
			      companyLocatView.ui.add(searchWidget, {
			        position: "top-right"
			      });
			      //On map click create graphic/ clear previous
			      companyLocatView.on("click", function(evt){
			        if (companyLocatView.graphics.items[0]) {
			          companyLocatView.graphics.removeAll();
			        }else {
			        }
			        companyLocatView.graphics.add(createGraphic(evt.mapPoint));
			      });

			      function createGraphic(point){
			        return new Graphic ({
			          geometry: point,
			          symbol: highlightedSymbol
			        });
			      }
			      //Show/hide Address input depending on the job tipe

			      $('#selOnRemote').on('change', function() {
			      	if ($('#selOnRemote').val() === 'yes') {
								//$("#inputAddressDiv").hide();
								$("#inputAddressCol").hide();
								$("#form > .row .col-md-4").removeClass("col-md-4").addClass("col-md-6");
							} else {
								$("#inputAddressCol").show();
								$("#form > .row .col-md-6").removeClass("col-md-6").addClass("col-md-4");
								//$("#inputAddressDiv").show();
							}
						});

			      //Submit button
						//*************

					  var $form = $('form');
					  $form.submit(function(event){
					   	event.preventDefault();
					    if ($('#selOnRemote').val()==='no' || $('#selOnRemote').val()==='negociate') {
					    	var address = GEODEV.jobs.address;
					    	if (GEODEV.jobs.companyLocatView.graphics.items[0]) {
					    		var location = GEODEV.jobs.companyLocatView.graphics.items[0].geometry;
					    	}else{
					    		return $("#warningMsng").html("Introduce una localización");
					    	}

								$('#inputLat').val(location.latitude);
								$('#inputLong').val(location.longitude);
								if (address) {
									$('#inputAddress').val(address);
									submitFormAndClose();
								}else{
									console.log("hay que hacer reverse geocoder");
									var lat = location.latitude.toString();
									var long = location.longitude.toString();
									var urlGeoCoder = "http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/reverseGeocode?f=pjson&location="+long+","+lat;
									$.getJSON(urlGeoCoder, function(data){
										if (data.address) {
											$('#inputAddress').val(data.address.Match_addr);
										}else{
											$('#inputAddress').val(long+","+lat);
										}
										submitFormAndClose();
									});
								}
							}
							else {
								console.log("no lat/long values beacuse of remote job");
								submitFormAndClose();
							}

							function submitFormAndClose(){
								$.post($form.attr('action'), $form.serialize(), function(response){
					      	console.log(response);
					      	$form.toggle(500);
					    	},'json');
							}
					    return false;
					   });

			 		  // *********************************
						// AJAX SIMPSONS POIS REQUEST
						// *********************************

					  window.GEODEV.jobs = {};
						$.getJSON("../assets/data/simpsonsPOIs.json", function(datos){
							 GEODEV.jobs.simpsonsAllPOIs = datos.POIS;
							GEODEV.jobs.simpsonsPOIs = [];
							getRandomSimpsPOIs(datos.POIS);
						});

					  // *********************************
						// AJAX JOBS DATA REQUEST
						// *********************************

						$.getJSON("../api/jobs?callback=?", function(datos){
							GEODEV.jobs.data = datos;
							GEODEV.jobs.data.forEach(function(element){
								var date = new Date(element.date);
								element.date = (date.getDate() + '/' + (date.getMonth() + 1) + '/' +  date.getFullYear());
							});
						
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
							// 1.Highlight job location
							// 2.GoTo Job location
							// *********************************
							GEODEV.jobs.prevJobShow;




							$('.collapse').on('show.bs.collapse', function (e) {

								try{
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
							  }catch(e){
							 	  Rollbar.error(e);
							  }
							});

						});

						function getRandomSimpsPOIs() {
							if (GEODEV.jobs.data && GEODEV.jobs.simpsonsAllPOIs){
								var count = 0;
							  for (i = 0; i < GEODEV.jobs.data.length; i++) {
							  	if (GEODEV.jobs.data[i].on_remote === "yes") {
										var POIIndex = Math.floor(Math.random() * (54-count));
								    GEODEV.jobs.simpsonsPOIs[count] = GEODEV.jobs.simpsonsAllPOIs[POIIndex];
								    GEODEV.jobs.simpsonsAllPOIs.splice(POIIndex,1);
								    count++;
								  }
								}
								checkViewsThenDraw();
							}
						}

						function createSymbol (url){
								return new PictureMarkerSymbol({
								  url: url,
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

					}catch(e){
						e = e.toString();
						Rollbar.error("ERROR OCCURRED", e);
						if (e.indexOf("Map") !== -1) {
						location.reload();
						} else {
						console.log("unexpected error: " + e);
						}

					}

				});
			</script>
			<?php {/literal} ?>
			{include file="footer.tpl"}
		</div>
	</body>
</html>
