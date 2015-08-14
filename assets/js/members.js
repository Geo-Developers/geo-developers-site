define(['jquery','cookies','base', 'typeahead'], function($, Cookies, base){
    var Methods = {
        init: function(seccion){

            base.init(Cookies);

            $("#search").typeahead({
                source: GEOSKILLS
            });
            $("#search-form button").click(function(){
                $("#search-form").submit();
                console.log("Yeah!");
            });
        }
    };
    return Methods;
});