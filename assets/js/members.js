define(['jquery','cookies','base', 'typeahead', 'jsrender'], function($, Cookies, base){
    var Methods = {
        init: function(seccion){

            base.init(Cookies);

            $("#search").typeahead({
                source: SKILLS
            });
            $("#search-form button").click(function(){
                $("#search-form").submit();
                console.log("Yeah!");
            });

            $('[data-target="#modalTechs"]').click(function(e){
                e.preventDefault();
                console.log("Yeah");
            });

            $("#loadMembers").click(function(){
                template = $.templates("#memberTmpl");

                var page = parseInt($(this).attr("data-page"));

                $(this).attr("data-page", page+1);


                var members = USERS.slice(page*24, (page*24+24));

                if(members.length < 24){
                    $(this).hide();
                }

                htmlOutput = template.render(members);
                $("#member-list").append(htmlOutput);
            });
            $("#loadMembers").click();
        }
    };
    return Methods;
});