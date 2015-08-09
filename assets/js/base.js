/*
	This script is load on every page
*/
"use strict";

define(['jquery', 'dropdown'], function($) {

  var Methods = {
 
		init: function(Cookies) {
            var showCookies = true;

            try{
                if(Cookies.get("cookies") === "true" || USER.cookies === 1) {
                    showCookies = false;
                }
            }catch(e){}

			if(showCookies){
                document.getElementById('cookies').className = "show";
                window.closeCookies = function () {
                    document.getElementById('cookies').className = "";

                    Cookies.set("cookies", "true");
                    try{
                        $.ajax({
                            type: "POST",
                            url: GEODEV.rootpath + "api/user/" + USER.id,
                            data: {cookies: 1},
                            dataType: "json",
                            success: function (r) {
                                if (r.status !== "success") {
                                        alert("Error: " + r.message);
                                } else {
                                    console.log("r=", r);
                                }
                            }
                        });
                    }catch(e){}
                }
			}else{
                var showNewsletter = true, visits;
                try{
                    if (Cookies.get("geodev-academy") === "true" || USER["mailchimp_euid"] === 1){
                        showNewsletter = false;
                    }
                }catch(e){
                    console.log("Exception: ",e)
                }

				visits = parseInt(Cookies.get("visits"));
				if(!visits){
					Cookies.set("visits",1);
				}else{
					Cookies.set("visits",visits+1);
				}
				if(showNewsletter && visits > 3){
					document.getElementById('geodev-academy').className = "show";
					$("#mc-embedded-subscribe-form").submit(function(){
						closeCookies();
					});
					window.closeCookies = function(){
						document.getElementById('geodev-academy').className = "";
						Cookies.set("geodev-academy","true");
                        try{
                            $.ajax({
                                type: "POST",
                                url: GEODEV.rootpath + "api/user/" + USER.id,
                                data: {mailchimp_euid:1},
                                success: function(r){console.log("r=",r)}
                            });
                        }catch(e){}
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
