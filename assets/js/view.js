define(['jquery','cookies','base', 'bootstrap','jsrender', 'raty'], function($,Cookies,base){
    var Methods = {
        init: function(type){

            base.init(Cookies);

            //$.getScript('http://www.youtube.com/iframe_api');
            var tag = document.createElement('script');
            tag.src = "http://www.youtube.com/player_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

            var options = {
                path: GEODEV.rootpath+'images/',
                half: true,
                hints: ['mala', 'pobre', 'regular', 'buena', 'genial'],
                starOff : 'star-off.png',
                starOn  : 'star-on.png',
                scoreName: 'general-rate',
                score: function() {
                    return $(this).attr('data-score');
                }
            };


            // Load Mouseflow
            var _mfq = _mfq || [];
            (function() {
                var mf = document.createElement("script"); mf.type = "text/javascript"; mf.async = true;
                mf.src = "//cdn.mouseflow.com/projects/e104d3e4-82cc-4b5d-b477-ae31e9ed325d.js";
                document.getElementsByTagName("head")[0].appendChild(mf);
                console.log("Embed")
            })();


            if(typeof(USER) !== "undefined") {
                _mfq.push(["setVariable", "meetup_id", USER["meetup_id"]]);
                _mfq.push(["setVariable", "name", USER["name"] + " " + USER["last_name"]]);
                _mfq.push(["setVariable", "userid", USER["id"]]);
                _mfq.push(["setVariable", "email", USER["email"]]);
            }

            $('#general-rate').raty(options);

            options.scoreName = 'speaker-rate';
            $('#speaker-rate').raty(options);

            options.scoreName = 'tech-rate';
            $('#tech-rate').raty(options);

            $("button#rate").click(function(){
                var data = {
                    'general-rate': $("input[name='general-rate']").val(),
                    'speaker-rate': $("input[name='speaker-rate']").val(),
                    'tech-rate': $("input[name='tech-rate']").val(),
                    'comments': $("textarea[name='comments']").val()
                };
                var that = this;
                $(this).find("i").addClass("fa-circle-o-notch fa-spin");

                $.ajax({
                    type: "POST",
                    url: GEODEV.rootpath + "api/video/" + videoID + "/rate",
                    data: data,
                    dataType: "json",
                    success: function (r) {
                        $(that).find("i").removeClass("fa-circle-o-notch fa-spin");
                        if (r.status !== "success") {
                            alert("Error: " + r.message);
                        } else {
                            //console.log(r);
                            $("#rating-msg").fadeIn();
                            setTimeout(function(){$("#rating-msg").fadeOut()}, 3000);
                            $("#rating-msg").text(r.message);
                        }
                    }
                });
            });

            function onPlayerReady(event) {
                event.target.playVideo();
            }
            function onPlayerStateChange(event,element) {
                //When the video has ended
                if (event.data == YT.PlayerState.ENDED) {
                    //Get rid of the player
                    element.style.display = "none";
                }
            }
            window.onYouTubePlayerAPIReady = function () {
                var options = {
                    height: '285',
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
                //console.log("options=",options);
                window.player = new YT.Player('youtubeVideo', options);


            };

            if (type === "academy") {

                var selectVideo = function (i){
                    //console.log("Indice:",indexes[i-1]);
                    var $newSelected = $('[data-seek='+indexes[i-1]+']');
                    if(!$newSelected.hasClass("selected")){
                        $('.index.selected').removeClass('selected');
                        $newSelected.addClass("selected");
                    }
                    if(!$newSelected.hasClass("viewed")){
                        $newSelected.addClass("viewed");
                        progress[i-1][1] = 1;
                        window.updateProgress();
                    }
                };

                // MODAL PREFERENCES
                $("#preferences p i").addClass("fa-toggle-off");

                $(".grouping p").click(function(){
                    $(this).siblings("div").slideToggle()
                    $(this).find("i").toggleClass("fa-toggle-on");
                });

                $("#preferences").on( "submit", function( event ) {
                    event.preventDefault();

                    var that = this;
                    $(this).find("button i").addClass("fa-circle-o-notch fa-spin");

                    $.ajax({
                        type: "POST",
                        url: GEODEV.rootpath + "api/user/" + USER["meetup_id"] + "/preferences",
                        data: $( this ).serialize(),
                        dataType: 'json',
                        success: function (r) {
                            $(that).find("i").removeClass("fa-circle-o-notch fa-spin");
                            if (r.status !== "success") {
                                alert("Error: " + r.message);
                            } else {
                                $el = $("#preferences-msg");
                                $el.fadeIn();
                                setTimeout(function(){$el.fadeOut()}, 6000);
                                $el.text(r.message);
                            }
                        }
                    });
                });

                // END PREFERENCES

                $(".view").click(function(){
                    if($(this).parent().hasClass("viewed")){
                        //console.log("Quitamos visualizado");
                        $(this).parent().removeClass("viewed")
                        var i = indexes.indexOf($(this).parent().data('seek'));
                        progress[i][1]=0;
                        window.updateProgress();
                    }
                });

                window.updateProgress = function(){

                    var value = 0;
                    progress.forEach(function(el){
                        if(el[1]==1){
                            value += el[2];
                        }
                    });
                    value *= 100;
                    //console.log("Actualizamos % a ",value);
                    var rounded = parseInt(value);
                    if(rounded == 99){
                        rounded++;
                    }
                    $(".text .percentage").text(rounded);
                    $("#progress-container .progress-bar").css("width",rounded+"%");

                    $.ajax({
                        type: "POST",
                        url: GEODEV.rootpath + "api/user/" + USER["meetup_id"] + "/video",
                        data: {
                            video_id: videoID,
                            indexes: progress,
                            progress: parseFloat(value.toFixed(2))
                        },
                        dataType: "json",
                        success: function (r) {
                            if (r.status !== "success") {
                                alert("Error: " + r.message);
                            } else {
                                //console.log(r);
                            }
                        }
                    });
                };

                var checkProgress = function(){
                    var i=0;
                    try {
                        while (player.getCurrentTime() >= indexes[i]) {
                            i++;
                        }
                        selectVideo(i);
                    }catch(e){
                        console.log(e);
                    }
                };
                setInterval(checkProgress, 3000);
                updateProgress();



                $(function() {
                    $(document).on('click', '.btnSeek .text, .btnSeek .time', function() {
                        var newTime = $(this).parent().data('seek');
                        //console.log("SeekTo=", newTime);
                        selectVideo(indexes.indexOf(newTime)+1);
                        player.seekTo(newTime, true);
                    });
                });
            }

            // If it is passed event
            //console.log("type=",type);
            if (type === "webinars") {

                //$("li.active").hide();
                //$("a[href='#home']").click();
                //$("#youtubeVideo").addClass(type);

                /*jQuery.getScript("https://cdn.firebase.com/js/client/2.0.2/firebase.js", function(){
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
                                        // Display rooms id
                                        chat._chat.getRoomList(function(r){console.log(r);})
                                    },2000);
                                } else {
                                    chatRef.authAnonymously(function(error, authData) {
                                        if (error) {
                                            //console.log(error);
                                        }
                                    });
                                }
                            }
                        });
                    });
                });*/

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
