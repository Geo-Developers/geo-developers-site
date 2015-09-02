define(['jquery', 'cookies', 'base', 'bootstrap', 'jsrender'], function($, Cookies, base){
    var Methods = {
        init: function(){

            base.init(Cookies);

            $("#skillList .btn").click(function(e){
                e.preventDefault();
                //console.log("inputGeoSkill=",);
                var skill = $("#inputGeoSkill").val()
                if($('[data-skill="'+skill+'"]').length==1){
                    alert("Ya tienes este skill en la lista");
                    return -1;
                }
                template = $.templates("#skillTmpl");
                htmlOutput = template.render({
                    skill_name: skill
                });
                $('ul.skills').append(htmlOutput);
            });

            $(window).keydown(function(event){
                if(event.keyCode == 13){
                    event.preventDefault();
                    $("#skillList .btn").click();
                    return false;
                }
            });

            window.validateForm = function(){
                if($(".skills input").length == 0){
                    alert("Debes añadir qué tecnologías GIS conoces o te interesan");
                    return false;
                }
            };

            // TODO: check skills are defined on submit

            window.removeSkill = function(el){
                $(el).remove();
            };
        }
    };
    return Methods;
});
