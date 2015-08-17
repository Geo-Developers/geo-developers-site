define(['jquery','cookies','base','jsrender'], function($, Cookies, base){
    var Methods = {
        init: function(seccion){
            base.init(Cookies);

            var that = this;
            var apikey = "AIzaSyBWrR-O_l5STwv1EO7U_Y3JNOnVjexf710";// "AIzaSyDki-gYirztPuR0GNGX-0uOuTUowQtq9mI";
            var youtubeID = window.location.search.split("=")[1],
                api_url = "https://spreadsheets.google.com/feeds/list/14-tvNCiE3Brs4eHbZvuc3B92uQDAYl9qXUMkX1EC5jU/1/public/values?alt=json-in-script&callback=loadVideos";

            $(document).ready(function(){

                $("#filter").change(function(){ $("#search").val($(this).val());});

                setTimeout(function(){$('[data-target="#speak"]').removeClass("blink_me")}, 5000);

                window.onhashchange = function(){
                    hash = window.location.hash.substr(1);
                    $("#search").val(hash);
                    that.filter(hash);
                    $("#filter [selected='selected']").removeAttr("selected");
                    $("#filter [data-name='"+hash+"']").attr("selected","selected");
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

                $("#search").keyup(function(){
                    that.filter($("#search").val());
                });

                $("#filter").change(function(){
                    var val = $("#filter").val();
                    window.location.hash = val;
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

                $("#suggestBtn").click(function(){
                    var $this = $(this);
                    $this.addClass("disabled");

                    videos = $("#searchResults .selected");
                    if(videos.length == 0){
                        //alert("Debes seleccionar al menos un vídeo. Haz clic sobre el título para seleccionarlos.")
                        return -1;
                    }
                    data = {videos:[]};
                    $(videos).each(function(i,elem){
                        data.videos.push({
                            title: $(elem).find("p").text(),
                            url:$(elem).find("a").attr("href")
                        })
                    });

                    $.ajax({
                        type: "POST",
                        url: GEODEV.rootpath + "api/video/suggest",
                        data: data,
                        dataType: "json",
                        success: function (r) {
                            if (r.status !== "success") {
                                alert("Error: " + r.message);
                                $this.removeClass("disabled");
                            } else {
                                $("#suggestBtn").hide();
                                $("#suggestDone").show();
                                //console.log("r=", r);
                            }
                        }
                    });
                });

                $("#searchVideo").submit(function (e) {
                    e.preventDefault();
                    $("#suggestDone").hide();

                    $("#searchResults .selected").removeClass("selected");
                    var params = {
                        part: "snippet",
                        order: "viewcount",
                        q: $("#searchVideo input").val(),
                        type: "video",
                        videoDefinition: "high",
                        key: apikey
                    };
                    template = $.templates("#videoTmpl");
                    $.ajax({
                        type: "GET",
                        url: "https://www.googleapis.com/youtube/v3/search",
                        data: params,
                        dataType: "json",
                        success: function (r) {
                            console.log(r);
                            htmlOutput = template.render(r.items);
                            $("#searchResults").html(htmlOutput);
                            if(r.items.length > 0){
                                $("#suggestBtn").show();
                            }else{
                                $("#suggestBtn").hide();
                            }
                        }
                    });


                });
            }

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
            if($(".video:visible").length === 0){
                $("#no-results").show();
            }else{
                $("#no-results").hide();
            }
        }
    };
    return Methods;
});
