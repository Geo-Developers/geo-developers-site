define(['jquery','cookies','base','jsrender'], function($, Cookies, base){
    var Methods = {
        init: function(seccion){
            base.init(Cookies);

            var that = this;

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
