/*
	This script is load on every page
*/
"use strict";

define(['jquery', 'dropdown', 'tab', 'tooltip', 'bootstrap'], function($) {

  var Methods = {
 
		init: function(Cookies) {
            var showCookies = true;
            $('.tabs').tab();
            $('[data-toggle="tooltip"]').tooltip();
            //$('[data-toggle="modal"]').modal();
            try{
                if(Cookies.get("cookies") === "true" || USER.cookies === "1") {
                    showCookies = false;
                }
            }catch(e){}

            $('i[rel=popover], a[rel=popover]').popover({
                html: true,
                placement: $(this).data('placement'),
                trigger: 'hover',
                content: function () {
                    return '<img src="'+$(this).data('img') + '" style="width:200px; max-height: none;" />';
                }
            });

            $('[rel=popover][data-content]').popover({
                html: true,
                placement: $(this).data('placement'),
                trigger: 'hover',
                content: $(this).data('content')
            });
            $('[rel=popover][data-content][trigger="focus"]').popover({
                html: true,
                placement: $(this).data('placement'),
                trigger: 'focus',
                content: $(this).data('content')
            });

            $('[rel=popover][data-state=open]').popover('show');

			if(showCookies){
                document.getElementById('cookies').className = "show";
                window.closeCookies = function () {
                    document.getElementById('cookies').className = "";

                    Cookies.set("cookies", "true");
                    try{
                        $.ajax({
                            type: "POST",
                            url: GEODEV.rootpath + "api/user/" + USER["meetup_id"],
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
                    if (Cookies.get("geodev-academy") === "true" || USER["newsletter"] !== 0){
                        showNewsletter = false;
                    }
                }catch(e){
                    //console.log("Exception: ",e)
                }

				visits = parseInt(Cookies.get("visits"));
				if(!visits){
					Cookies.set("visits",1);
				}else{
					Cookies.set("visits",visits+1);
				}
				if(showNewsletter && visits > 3){
					$('#newsletter-footer').addClass("show");
					$("#mc-embedded-subscribe-form").submit(function(){
						closeCookies();
					});
					window.closeCookies = function(){
                        $('#newsletter-footer').removeClass("show");
						Cookies.set("geodev-academy","true");
                        try{
                            $.ajax({
                                type: "POST",
                                url: GEODEV.rootpath + "api/user/" + USER["meetup_id"],
                                data: {mailchimp_euid:1},
                                success: function(r){
                                    //console.log("r=",r);
                                }
                            });
                        }catch(e){}
					}
				}
			}
			$('.dropdown-toggle').dropdown();	

			//console.log("Ejecutamos");

			/* Mixpanel tracking */
            if(typeof(USER) !== "undefined"){
                mixpanel.people.set(USER);
                // identify must be called along with people.set
                mixpanel.identify(USER["meetup_id"]);

                mixpanel.register_once({
                    'meetup_id': USER["meetup_id"],
                    'name': USER["name"]+" "+USER["last_name"],
                    'email': USER["email"]
                });
            }

			var $body = $("body"),
                pageID = $body.attr("id");

            if($body.hasClass("video-view")){
                var videoProps = JSON.parse("{"+$("body").attr("mp-props")+"}");
                mixpanel.track("View page [" + pageID + "]", videoProps);
            }else{
                mixpanel.track("View page [" + pageID + "]");
            }




            $("[mp-name]").click(function(){
                var $this = $(this),
                    evtName = $this.attr("mp-name") + " [" + pageID + "]";

                if($this.attr("mp-props") || $("body").hasClass("video-view")){
                    var props;
                    if($this.attr("mp-props")){
                        props = JSON.parse("{"+$this.attr("mp-props")+"}");
                    }else{
                        props = {};
                    }

                    if($("body").hasClass("video-view")){
                        var videoProps = JSON.parse("{"+$("body").attr("mp-props")+"}");

                        props["videoId"] = videoProps.videoId;
                        props["videoTitle"] = videoProps.videoTitle;
                        try{
                            props["playerTime"] = player.getCurrentTime();
                        }catch(e){
                            console.log(e);
                        }
                    }
                    mixpanel.track(evtName, props);

                    console.log("%s, %s", evtName,  JSON.stringify(props, null, "\t"));
                }else{
                    mixpanel.track(evtName);
                    console.log(evtName);
                }

            });
		}

	}
	return Methods;
});
