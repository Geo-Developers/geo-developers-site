define(['jquery','cookies','base', 'typeahead'], function($, Cookies, base){
    var Methods = {
        init: function(seccion){

            base.init(Cookies);

            $('.typeahead').typeahead()
            $("#search").typeahead({
                source: GEOSKILLS
            });
            $("#search-form button").click(function(){
                $("#search-form").submit();
                console.log("Yeah!");
            });
//example_collection.json
// ["item1","item2","item3"]

        }
    };
    return Methods;
});