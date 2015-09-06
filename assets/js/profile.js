define(['jquery','cookies','base','jsrender', 'typeahead'], function($,Cookies,base){
    var Methods = {
        init: function(action){
            //debugger;
            $('#donut_single[rel=popover]').popover({
                html: true,
                placement: 'left',
                trigger: 'hover',
                content: function () {
                    var html = $('#donut_info').html();
                    //console.log("html=",html);
                    return html;
                }
            });
            var that = this;
            if(action=="edit"){
                $(document).ready(function(){
                    that.initEdit();
                    hash = window.location.hash;
                    $("a[href='"+hash+"']").click();
                });

            }

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
                }
            });
        },
        initEdit: function(){
            $("#studies").typeahead({source: studies});
            $("#occupation").typeahead({source: occupation});
            $("#geoskill").typeahead({source: GEOSKILLS});
            $("#skill").typeahead({source: OTHERSKILLS});

            $('form').on('keyup keypress', function(e) {
                var code = e.keyCode || e.which;
                if (code == 13) {
                    e.preventDefault();
                    return false;
                }
            });

            $(".skillList button").click(function(){
                var $target = $(this).data("target");
                var $input = $(this).data("input");
                $($target).val($($input).val());

                $('.addSkill[data-target="'+$target+'"]').click();
            });

            $(".focus").focusin(function(){
                $id = $(this).data("focus");
                $($id).addClass("blink_me");
            });
            $(".focus").focusout(function(){
                $id = $(this).data("focus");
                $($id).removeClass("blink_me");
            });

            $(".addSkill").click(function(e){
                var skill_name = $($(this).data("target")).val(),
                    table = $(this).data("table"),
                    that = this,
                    data = {
                        skill_name: skill_name
                    };
                if(!skill_name){
                    return 0;
                }
                $(this).find("i").addClass("fa-circle-o-notch fa-spin");
                $(this).addClass("disabled");

                if($(this).data("isgis")){
                    data["is_gis"] = 1;
                }
                $.ajax({
                    type: "POST",
                    url: GEODEV.rootpath + "api/user/" + USER["meetup_id"] + "/skill",
                    data: data,
                    dataType: "json",
                    success: function (r) {
                        $(that).find("i").removeClass("fa-circle-o-notch fa-spin");
                        $(that).removeClass("disabled");
                        //$(that).addClass("fa-plus");

                        if (r.status !== "success") {
                            alert("Error: " + r.message);
                        } else {
                            //console.log("r=", r);
                            $($(that).data("target")).val("");
                            template = $.templates("#skillTmpl");
                            htmlOutput = template.render({
                                id: r.message,
                                name: skill_name
                            });
                            $(table).append(htmlOutput);

                        }
                    }
                });
            });

            $('[data-table="#geoSkillTable"]').removeClass("disabled");

            window.removeSkill = function(id, elemId){
                $.ajax({
                    type: "POST",
                    url: GEODEV.rootpath + "api/user/" + USER["meetup_id"] + "/skill",
                    data: {
                        skill_id: id,
                        _METHOD: "DELETE"
                    },
                    dataType: "json",
                    success: function (r) {
                        if (r.status !== "success") {
                            alert("Error: " + r.message);
                        } else {
                            $(elemId).remove();
                        }
                    }
                });
            }

        }
    };
    return Methods;
});