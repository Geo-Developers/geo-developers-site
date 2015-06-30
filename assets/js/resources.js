define(['jquery','cookies','base'], function($, Cookies, base){
  var Methods = {
    init: function(seccion){

      base.init(Cookies);

    }
  };
  return Methods;
});