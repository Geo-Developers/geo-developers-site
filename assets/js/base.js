define(['jquery', 'dropdown'], function($) {

  var Methods = {
 
		init: function(Cookies) {

			if(Cookies.get("cookies") !== "true"){
				document.getElementById('cookies').className = "show";
				window.closeCookies = function(){
					document.getElementById('cookies').className = "";
					Cookies.set("cookies","true");
				}
			}else{
				var visits = parseInt(Cookies.get("visits"));
				if(!visits){
					Cookies.set("visits",1);
				}else{
					Cookies.set("visits",visits+1);
				}
				if(Cookies.get("geodev-academy") !== "true" && visits > 3){
					document.getElementById('geodev-academy').className = "show";
					$("#mc-embedded-subscribe-form").submit(function(){
						closeCookies();
					});
					window.closeCookies = function(){
						document.getElementById('geodev-academy').className = "";
						Cookies.set("geodev-academy","true");
					}
				}
			}
			$('.dropdown-toggle').dropdown();	
		}

	}
	return Methods;
});
