define(['jquery','cookies','base','jsrender'], function($, Cookies, base){
    var Methods = {
        init: function(){
            base.init(Cookies);
            var apikey = "AIzaSyBWrR-O_l5STwv1EO7U_Y3JNOnVjexf710";

            $("#suggestDone .btn").click(function(){
                $("#confirm ul").empty();
                $("#suggestDone").hide();
                $("#confirm .btn-primary").show();
                $("#searchResults").empty();
                $("#youtubeNavigation").hide();
                $("#searchVideo input").val("");
                $("#submit-url input").val("");
                $("#confirm .none").show();
                $("#confirm .pending").hide();
                GEODEV["youtube"].selected = [];
            });

            $("#confirm .btn-primary").click(function(){
                var $this = $(this);

                $this.find("i").addClass("fa-circle-o-notch fa-spin");
                $this.addClass("disabled");

                if(GEODEV["youtube"].selected.length == 0){
                    //alert("Debes seleccionar al menos un vídeo. Haz clic sobre el título para seleccionarlos.")
                    return -1;
                }
                data = {
                    videos: GEODEV["youtube"].selected
                };

                $.ajax({
                    type: "POST",
                    url: GEODEV.rootpath + "api/video/suggest",
                    data: data,
                    dataType: "json",
                    success: function (r) {
                        $this.find("i").removeClass("fa-circle-o-notch fa-spin");
                        if (r.status !== "success") {
                            alert("Error: " + r.message);
                            $this.removeClass("disabled");
                        } else {
                            $this.hide();
                            $("#suggestDone").show();
                            //console.log("r=", r);
                        }
                    }
                });
            });

            GEODEV["youtube"] = {
                page: 0,
                requests: 1,
                selected: [],
                videos: [],
                reset: function(){
                    GEODEV["youtube"].requests = 1;

                    GEODEV["youtube"].videos = [];
                    GEODEV["youtube"].page = 0;

                },
                init: function(){
                    GEODEV["youtube"].reset();
                    GEODEV["youtube"].params.q = $("#searchVideo input").val();

                    var el = $("#searchVideo .search");
                    el.addClass("disabled");
                    el.find("i").addClass("fa fa-circle-o-notch fa-spin");
                    $("#suggestDone").hide();
                    $("#searchResults .selected").removeClass("selected");

                    GEODEV["youtube"].loadVideos();
                },
                params: {
                    part: "snippet",
                    order: "relevance",
                    type: "video",
                    videoDefinition: "high",
                    key: apikey
                },

                loadVideos: function(pageToken){
                    that = this;
                    if(pageToken){
                        GEODEV["youtube"].params["pageToken"] = pageToken;
                    }

                    $.ajax({
                        type: "GET",
                        url: "https://www.googleapis.com/youtube/v3/search",
                        data: GEODEV["youtube"].params,
                        dataType: "json",
                        success: function (r) {
                            GEODEV["youtube"].videos = GEODEV["youtube"].videos.concat(r.items);
                            var max = GEODEV["youtube"].requests;
                            if(GEODEV["youtube"].videos.length < (30*max) && r.nextPageToken){
                                GEODEV["youtube"].loadVideos(r.nextPageToken)
                            }else{
                                GEODEV["youtube"].renderVideos();
                                GEODEV["youtube"].requests++;
                                var el = $("#searchVideo .search");
                                el.removeClass("disabled");
                                el.find("i").removeClass("fa fa-circle-o-notch fa-spin");
                            }
                        }
                    });
                },
                renderVideos: function(){
                    var counter = GEODEV["youtube"].page;
                    var data = GEODEV["youtube"].videos.slice(15*counter,15*counter+15);

                    template = $.templates("#videoTmpl");
                    htmlOutput = template.render(data);
                    $("#searchResults").append(htmlOutput);

                    $(GEODEV["youtube"].selected).each(function(i,elem){
                        $('[data-url="'+elem.url+'"]').addClass("selected");
                    });
                    if(GEODEV["youtube"].videos.length > 0){
                        if(data.length == 0){
                            GEODEV["youtube"].loadVideos();
                        }
                        $("#youtubeNavigation").show();
                    }else{
                        $("#youtubeNavigation").hide();
                    }
                },

                renderPendingList: function(){
                    template = $.templates("#confirmTpl");
                    htmlOutput = template.render(GEODEV.youtube.selected);
                    if(GEODEV.youtube.selected.length > 0){
                        $("#confirm .none").hide();
                        $("#confirm .pending").show();
                        $("#confirm .btn-primary").removeClass("disabled");
                    }else{
                        $("#confirm .none").show();
                        $("#confirm .pending").hide();
                        $("#confirm .btn-primary").addClass("disabled");
                    }
                    $("#confirm ul").html(htmlOutput);
                }
            };

            window.deleteElem = function(el){
                $url = $(el).data("url");
                $('[data-url="'+$url+'"]').removeClass("selected");
                $(GEODEV["youtube"].selected).each(function(i,elem){
                    if(elem.url == $url){
                        GEODEV["youtube"].selected.splice(i, 1);
                    }
                });
                GEODEV["youtube"].renderPendingList();
            };

            window.selectVideo = function(elem){

                $(elem).toggleClass('selected');

                var video = {
                    title: $(elem).find("p").text(),
                    url:$(elem).find("a").attr("href")
                };

                if($(elem).hasClass("selected")){
                    GEODEV["youtube"].selected.push(video);
                }else{
                    $(GEODEV["youtube"].selected).each(function(i,elem){
                        if(elem.url == video.url){
                            GEODEV["youtube"].selected.splice(i, 1);
                        }
                    });
                }

                GEODEV["youtube"].renderPendingList();

            };

            $('#searchVideo input').keypress(function (e) {
                if (e.which == 13) {
                    $("#searchResults").empty();
                    GEODEV["youtube"].init();
                }
            });
            $('#searchVideo .search').click(function(){
                $("#searchResults").empty();
                GEODEV["youtube"].init();
            });

            var addByUrl = function(el){
                $elBtn = $("#submit-url");
                $elBtn.find(".btn").addClass("disabled");
                $elBtn.find("i").addClass("fa-circle-o-notch fa-spin");

                $.ajax({
                    type: "POST",
                    url: GEODEV.rootpath + "api/getTitle",
                    data: {
                        url: $(el).val()
                    },
                    dataType: "json",
                    success: function (r) {
                        var video = {
                            title: r.message.title,
                            url: $(el).val()
                        };
                        $(el).val("");
                        $elBtn.find(".btn").removeClass("disabled");
                        $elBtn.find("i").removeClass("fa-circle-o-notch fa-spin");

                        GEODEV["youtube"].selected.push(video);
                        GEODEV["youtube"].renderPendingList();
                    }
                });

            };

            $("#submit-url input").keypress(function (e) {
                if (e.which == 13) {
                    addByUrl(this);
                }
            });
            $("#submit-url .btn").click(function(){
                addByUrl("#submit-url input");
            });


            //suggestBtn
            $("#loadMore").click(function(e){
                GEODEV["youtube"].page++;
                GEODEV["youtube"].renderVideos();
            });
            /*
            $("#searchVideo .after").click(function(e){
                GEODEV["youtube"].page++;

                GEODEV["youtube"].renderVideos();
                if(GEODEV["youtube"].page > 0){
                    $("#searchVideo .before").removeClass("disabled");
                }else{
                    $("#searchVideo .before").addClass("disabled");
                }
            });
            $("#searchVideo .before").click(function(e) {
                GEODEV["youtube"].page--;
                GEODEV["youtube"].renderVideos();
                if(GEODEV["youtube"].page > 0){
                    $(this).removeClass("disabled");
                }else{
                    $(this).addClass("disabled");
                }
            });*/
        }
    };
    return Methods;
});
