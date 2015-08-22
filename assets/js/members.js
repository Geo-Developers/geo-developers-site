define(['jquery','cookies','base', 'typeahead'], function($, Cookies, base){
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
        }
    };
    return Methods;
});