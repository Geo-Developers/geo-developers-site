define(['jquery'], function($) {

  var Methods = {
 
		init: function(Cookies) {

			if(Cookies.get("cookies") !== "true"){
				document.getElementById('cookies').className = "show";
				window.closeCookies = function(){
					document.getElementById('cookies').className = "";
					Cookies.set("cookies","true");
				}
			}else{
				if(Cookies.get("geodev-academy") !== "true"){
					document.getElementById('geodev-academy').className = "show";
					window.closeCookies = function(){
						document.getElementById('geodev-academy').className = "";
						Cookies.set("geodev-academy","true");
					}
				}
			}
			
		}
	}
	return Methods;
});
