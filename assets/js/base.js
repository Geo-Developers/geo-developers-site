/*
	This script is load on every page
*/

define(['jquery', 'dropdown'], function($) {

  var Methods = {
 
		init: function(Cookies) {

			if(Cookies.get("cookies") !== "true"){
                if(typeof(USER) === "undefined" || USER.cookies !== 1) {
                    document.getElementById('cookies').className = "show";
                    window.closeCookies = function () {
                        document.getElementById('cookies').className = "";

                        Cookies.set("cookies", "true");
                        if (typeof(USER) !== "undefined") {
                            $.ajax({
                                type: "POST",
                                url: GEODEV.rootpath + "api/user/" + USER.id + "/update",
                                data: {cookies: 1},
                                dataType: "json",
                                success: function (r) {
                                    if (r.status !== "success") {
                                        +
                                            alert("Error: " + r.message);
                                    } else {
                                        console.log("r=", r);
                                    }
                                }
                            });
                        }
                    }
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
                        /*$.ajax({
                            type: "POST",
                            url: "/new/api/user/139909072/update",
                            data: {newsletter:1},
                            success: function(r){console.log("r=",r)}
                        });*/
					}
				}
			}
			$('.dropdown-toggle').dropdown();	

			console.log("Ejecutamos");

			/* Mixpanel tracking */
            if(typeof(USER) !== "undefined"){
                mixpanel.people.set(USER);
                // identify must be called along with people.set
                mixpanel.identify(USER.id);
            }

			var pageID = $("body").attr("id");
			mixpanel.track(
		    "View page [" + pageID + "]"/*,
		    { "Banner Color": "Blue" }*/
			);
		}

	}
	return Methods;
});
