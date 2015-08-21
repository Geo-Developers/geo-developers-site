/*
	Miniport by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/

define(['jquery','cookies','base','skel.min','skel-viewport.min','util'], function($, Cookies, base, skel, view) {
	var Methods = {
		init:function(){
			
			base.init(Cookies);

            if(typeof skel.breakpoints == "function"){
                skel
                    .breakpoints({
                        desktop: '(min-width: 737px)',
                        tablet: '(min-width: 737px) and (max-width: 1200px)',
                        mobile: '(max-width: 736px)'
                    })
                    .viewport({
                        breakpoints: {
                            tablet: {
                                width: 1080
                            }
                        }
                    });
            }

			$(function() {
				var	$window = $(window),
					$body = $('body');
				// Disable animations/transitions until the page has loaded.
					$body.addClass('is-loading');

					$window.on('load', function() {
						$body.removeClass('is-loading');
					});

				// Fix: Placeholder polyfill.
					$('form').placeholder();

				// Prioritize "important" elements on mobile.
					skel.on('+mobile -mobile', function() {
						$.prioritize(
							'.important\\28 mobile\\29',
							skel.breakpoint('mobile').active
						);
					});

				// CSS polyfills (IE<9).
					if (skel.vars.IEVersion < 9)
						$(':last-child').addClass('last-child');

				// Scrolly.
					$window.load(function() {

						var x = parseInt($('.wrapper').first().css('padding-top')) - 100;
                        if(typeof $('#nav a, .scrolly').scrolly == "function"){
                            $('#nav a, .scrolly').scrolly({
                                speed: 1000,
                                offset: x
                            });
                        }

					});

			});
		}
	};
	return Methods;
});