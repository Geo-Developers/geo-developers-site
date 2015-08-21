define(['jquery', 'bootstrap', 'jsrender'], function($){
    var Methods = {
        init: function(){

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

            // TODO: check skills are defined on submit

            window.removeSkill = function(el){
                $(el).remove();
            };
        }
    };
    return Methods;
});
