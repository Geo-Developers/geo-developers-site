var conf = {
	baseUrl: '/new/assets/js',
	'shim': {
      "bootstrap" : 				{ deps: ['jquery'] },
      'bootstrap/modal': 		{ deps: ['jquery'], exports: '$.fn.modal' },
      'bootstrap/dropdown': { deps: ['jquery'], exports: '$.fn.dropdown' },
      'jsrender': 					{ deps: ['jquery'], exports: '$.templates' },
      'main': 							{ deps: ['jquery'], exports: 'jQuery'},
      'util': 							['jquery'],
      'views': 							['jquery', 'jsrender', 'base'],
      'academy': 						['jquery', 'jsrender', 'base'],
      'main': 							['jquery', 'util', 'base']
  },
  paths:{
		jquery: [
			'http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min',
			'jquery'
		],
		jsrender: [
			'http://www.jsviews.com/download/jsrender',
			'jsrender'
		],
		disqus: [
			'https://geodevelopers.disquscdn.com/embed',
			'disqus'
		],
		bootstrap: [
			"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js",
			"bootstrap"
		],
		cookies: [
			"cookies",
			"https://raw.githubusercontent.com/ScottHamper/Cookies/master/dist/cookies.min.js"
		],
		dropdown:[
			"dropdown"
		]
              
	}
}

requirejs.config(conf);
