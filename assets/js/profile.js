define(['jquery','cookies','base', 'bootstrap','jsrender', 'modal'], function($,Cookies,base){
    var Methods = {
        init: function(type){
            //debugger;
            $('#donut_single[rel=popover]').popover({
                html: true,
                placement: 'left',
                trigger: 'hover',
                content: function () {
                    var html = $('#donut_info').html();
                    console.log("html=",html);
                    return html;
                }
            });

            base.init(Cookies);
            $("#vote").click(function(e){
                e.preventDefault();
                if(typeof(USER) !== "undefined"){
                    $.ajax({
                        type: "POST",
                        url: GEODEV.rootpath + "api/vote/" + refered,
                        data: {
                            //action: "add"
                        },
                        dataType: "json",
                        success: function (r) {
                            if (r.status !== "success") {
                                alert("Error: " + r.message);
                            } else {
                                var referrers = $("#referrers"),
                                    votes = $("#vote");
                                if(r["recommended"]){
                                    //TODO: añadir o quitar dinámicamente

                                    if(referrers.find("[data-referrer]:visible").length == 0){
                                        referrers.find(".title").slideDown();
                                    }
                                    votes.addClass("recommended");
                                    votes.removeClass("btn-primary");
                                    votes.addClass("btn-danger");
                                    $($("[data-referrer="+USER["meetup_id"]+"]")[0]).slideDown();

                                }else{
                                    if(referrers.find("[data-referrer]:visible").length == 1){
                                        referrers.find(".title").slideUp();
                                    }
                                    votes.removeClass("recommended");
                                    votes.addClass("btn-primary");
                                    votes.removeClass("btn-danger");

                                    $($("[data-referrer="+USER["meetup_id"]+"]")[0]).slideUp();

                                }
                                console.log("r=", r);
                            }
                        }
                    });
                }else{
                    $('#loginModal').modal();
                }
            });
        }
    };
    return Methods;
});