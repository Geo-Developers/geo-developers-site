define(['jquery','cookies','base','jsrender'], function($, Cookies, base){
    var Methods = {
        init: function(seccion){
            base.init(Cookies);

            var that = this;
            var apikey = "AIzaSyBWrR-O_l5STwv1EO7U_Y3JNOnVjexf710";// "AIzaSyDki-gYirztPuR0GNGX-0uOuTUowQtq9mI";
            var youtubeID = window.location.search.split("=")[1],
                api_url = "https://spreadsheets.google.com/feeds/list/14-tvNCiE3Brs4eHbZvuc3B92uQDAYl9qXUMkX1EC5jU/1/public/values?alt=json-in-script&callback=loadVideos";

            $(document).ready(function(){

                loadVideos();

                $("#search").keyup(function(){
                    that.filter($("#search").val());
                });
                $("#filter").change(function(){
                    var val = $("#filter").val();
                    //if(val === "all")
                    that.filter(val);
                });
            });

            if(seccion === "videos") {

                $("#speakBtn").click(function(){
                    var $this = $(this);
                    $this.addClass("disabled");
                    $.ajax({
                        type: "POST",
                        url: GEODEV.rootpath + "api/user/" + USER.meetup_id + "/speak",
                        dataType: "json",
                        success: function (r) {
                            if (r.status !== "success") {
                                alert("Error: " + r.message);
                                $this.removeClass("disabled");
                            } else {
                                $this.removeClass("btn-warning");
                                $this.addClass("btn-success");
                                $this.text("¡Gracias!, en breve nos pondremos en contacto contigo.");
                                //console.log("r=", r);
                            }
                        }
                    });
                });

                $("#searchVideo").submit(function (e) {
                    e.preventDefault();
                    var params = {
                        part: "snippet",
                        order: "viewcount",
                        q: $("#searchVideo input").val(),
                        type: "video+",
                        videoDefinition: "high",
                        apikey: apikey
                    };

                    $.ajax({
                        type: "GET",
                        url: "https://www.googleapis.com/youtube/v3/search",
                        data: params,
                        dataType: "json",
                        success: function (r) {
                            console.log(r);
                            // TODO: Add video list to the container
                        }
                    });
                });
            }

            window.loadVideos = function (){

                window.onhashchange = function(){
                    hash = window.location.hash.substr(1);
                    $("#search").val(hash);
                    that.filter(hash);
                };
                var tags = [];
                tags = tags.sort();
                filter = $("#filter");

                tags.forEach(function(elem){
                    if(elem !== ""){
                        option = $("<option></option>").text(elem);
                        option.attr("value", elem);
                        filter.append(option);
                    }
                });
            };

            window.view = function(youtubeID){
                window.location.href='view.php?id='+youtubeID;
            };
        },
        filter: function(val){
            if(val === ""){
                $(".video").show();
            }else{
                $(".video").each(function(i, elem){
                    cadena = $(elem).data("tags") + $(elem).data("title")

                    if(cadena.toLowerCase().indexOf(val.toLowerCase())==-1){
                        $(elem).hide();
                    }else{
                        $(elem).show();
                    }
                });
            }
        }
    };
    return Methods;
});
