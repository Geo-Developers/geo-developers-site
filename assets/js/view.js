define(['jquery','cookies','base', 'bootstrap','jsrender'], function($,Cookies,base){
    var Methods = {
        init: function(type){

            base.init(Cookies);

            $.getScript('http://www.youtube.com/iframe_api');

            window.onYouTubePlayerAPIReady = function () {
                var options = {
                    height: '310',
                    width: '640',
                    videoId: youtubeID,
                    playerVars: {
                        'start': 159,
                        'autoplay': 0,
                        'controls': 1
                    }
                };
                if(type === "webinars"){
                    options["height"]= '365';
                }
                console.log("options=",options);
                window.player = new YT.Player('youtubeVideo', options);
            };

            $(function() {
                $(document).on('click', '.btnSeek', function() {
                    player.seekTo($(this).data('seek'), true);
                });
            });

            // If it is passed event
            console.log("type=",type);
            if (type === "webinars") {

                $("li.active").hide();
                $("a[href='#home']").click();
                //$("#youtubeVideo").addClass(type);

                jQuery.getScript("https://cdn.firebase.com/js/client/2.0.2/firebase.js", function(){
                    jQuery.getScript("https://cdn.firebase.com/libs/firechat/2.0.1/firechat.min.js", function(){

                        var chatRef = new Firebase("https://blistering-fire-8130.firebaseio.com");
                        var chat = new FirechatUI(chatRef, document.getElementById("firechat-wrapper"));

                        chatRef.authAnonymously(function(error, authData) {
                            $("#firechat-wrapper").css('visibility','visible');
                            if (error) {
                                console.log("Login Failed!", error);
                            } else {
                                //console.log("Authenticated successfully with payload:", authData);
                                if (authData) {
                                    chat.setUser(authData.uid, "Anonymous" + authData.uid.substr(10, 8));

                                    setTimeout(function() {
                                        $("#spinner").hide();
                                        $("#firechat #firechat-tab-content").css("border-top","1px solid #bbb");
                                        if(firechat != ""){
                                            chat._chat.enterRoom(firechat);
                                        }
                                    },2000);
                                } else {
                                    chatRef.authAnonymously(function(error, authData) {
                                        if (error) {
                                            console.log(error);
                                        }
                                    });
                                }
                            }
                        });
                    });
                });

                (function() {
                    var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                    dsq.src = 'http://s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5110fe544ae3cec6';
                    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                })();
            }
        }
    };
    return Methods;
});