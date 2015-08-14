"use strict";

var conf = {
    baseUrl: '/assets/js',
    'shim': {
        'bootstrap' : 				{ deps: ['jquery'], exports: 'jquery' },
        'bootstrap/modal': 		    { deps: ['jquery'], exports: '$.fn.modal' },
        'bootstrap/dropdown':       { deps: ['jquery'], exports: '$.fn.dropdown' },
        'bootstrap/tab':            { deps: ['jquery'], exports: '$.fn.tab' },
        'bootstrap/tooltip':        { deps: ['jquery'], exports: '$.fn.tooltip' },
        'typeahead':                { deps: ['jquery'], exports: '$.fn.typeahead' },
        'jsrender': 				{ deps: ['jquery'], exports: '$.templates' },
        'util': 					['jquery'],
        'views': 					['jquery', 'jsrender', 'base'],
        'academy': 					['jquery', 'jsrender', 'base'],
        'main': 					{ deps: ['jquery', 'util', 'base'], exports: 'jQuery'}
    },
    paths:{
        jquery: [
            'jquery',
            'http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min'
        ],

        jsrender: [
            'jsrender',
            'http://www.jsviews.com/download/jsrender'
        ],
        disqus: [
            'https://geodevelopers.disquscdn.com/embed',
            'disqus'
        ],
        bootstrap: [
            "bootstrap",
            "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"
        ],
        cookies: [
            "cookies",
            "https://raw.githubusercontent.com/ScottHamper/Cookies/master/dist/cookies.min.js"
        ],
        dropdown:[
            "dropdown"
        ],
        tab:[
            "tab"
        ],
        tooltip:[
            "tooltip"
        ]


    }
};

if(window.location.host == "localhost"){
    conf.baseUrl = "/new" + conf.baseUrl;
}

requirejs.config(conf);
