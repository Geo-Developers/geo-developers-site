define(['jquery','cookies','base','jsrender'], function($, Cookies, base){
    var Methods = {
        init: function(seccion){
            base.init(Cookies);

            var that = this;

            var youtubeID = window.location.search.split("=")[1],
                api_url = "https://spreadsheets.google.com/feeds/list/14-tvNCiE3Brs4eHbZvuc3B92uQDAYl9qXUMkX1EC5jU/1/public/values?alt=json-in-script&callback=loadVideos";

            $(document).ready(function(){
                $.ajax({
                    url: api_url,
                    jsonp: "loadVideos",
                    dataType: "jsonp",
                    data: {format: "json"}
                });

                $("#search").keyup(function(){
                    that.filter($("#search").val());
                });
                $("#filter").change(function(){
                    var val = $("#filter").val();
                    //if(val === "all")
                    that.filter(val);
                });
            });

            window.loadVideos = function (data){
                var videos = [],
                    data = data.feed.entry,
                    tags = [], t, option, filter;

                $.each( data, function( key, val ) {

                    fechaEvento = val["gsx$fechammddaaaa"]["$t"];
                    t = val["gsx$tags"]["$t"].split(",");

                    data = {
                        title: val["gsx$charla"]["$t"],
                        id: val["gsx$idyoutube"]["$t"],
                        tags: []
                    };

                    if(seccion === "videos"){
                        data.webinar = false;
                        if (Date.parse(fechaEvento) < Date.now()) {

                            t.forEach(function(element){
                                if(tags.indexOf(element) === -1){
                                    tags.push(element);
                                    data.tags.push(element);
                                }
                            });

                            var contentDetails = "https://www.googleapis.com/youtube/v3/videos?id="+data.id+"&part=contentDetails&key=AIzaSyDki-gYirztPuR0GNGX-0uOuTUowQtq9mI";contentDetails
                            var statistiscs = "https://www.googleapis.com/youtube/v3/videos?id="+data.id+"&part=statistics&key=AIzaSyDki-gYirztPuR0GNGX-0uOuTUowQtq9mI";
                            var snippet = "https://www.googleapis.com/youtube/v3/videos?id="+data.id+"&part=snippet&key=AIzaSyDki-gYirztPuR0GNGX-0uOuTUowQtq9mI";
                            $.when(
                                $.getJSON(contentDetails , function(d){
                                    data.duration = d.items[0].contentDetails.duration;
                                }),
                                $.getJSON(statistiscs , function(d){
                                    data.viewCount = d.items[0].statistics.viewCount;
                                    data.likeCount = d.items[0].statistics.likeCount;
                                }),
                                $.getJSON(snippet , function(d){
                                    data.publishedAt = d.items[0].snippet.publishedAt;
                                })
                            ).then( function(videos){
                                videos.push(data);
                                $.ajax({
                                    type: "POST",
                                    url: GEODEV.rootpath + "api/video/" + data.id,
                                    data: data,
                                    dataType: "json",
                                    success: function (r) {
                                        if (r.status !== "success") {
                                            alert("Error: " + r.message);
                                        } else {
                                            //console.log("r=", r);
                                        }
                                    }
                                });
                            });
                        }
                    }else{
                        data.webinar = true;
                        if (Date.parse(fechaEvento) >= Date.now()) {
                            tags.push({tag: element});
                        }
                    }
                });


                $(".tags").each(function(i, elem){
                    var tagsContainer, tags;

                    tagsContainer = $(elem).find("ul");
                    tags = tagsContainer.text().split(",");
                    tagsContainer.empty();
                    if(tags.length > 0){

                        $(tags).each(function(j,elem2) {
                            if (elem !== "") {
                                var li = $("<li>");

                                li.append($("<a>", {
                                    href: "#" + elem2
                                }).text(elem2))
                                tagsContainer.append(li);
                            }
                        });
                    }

                });

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

                    if(cadena.indexOf(val)==-1){
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

