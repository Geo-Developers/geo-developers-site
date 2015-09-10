<!-- Contact -->
<div class="wrapper style4" id="footer">
    <article id="contact" class="container 75%">
        <div>
            <div class="row">
                <div class="12u">

                    <ul class="social">
                        <li><a href="http://www.twitter.com/Geo_Developers/" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
                        <!--<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
                        <li><a href="#" class="icon fa-dribbble"><span class="label">Dribbble</span></a></li>
                        <li><a href="#" class="icon fa-linkedin"><span class="label">LinkedIn</span></a></li>
                        <li><a href="#" class="icon fa-tumblr"><span class="label">Tumblr</span></a></li>
                        -->
                        <li><a href="https://www.youtube.com/channel/UC5Kegds6aV88wjdAhqQ5Wsg?sub_confirmation=1" class="icon fa-youtube"><span class="label">YouTube</span></a></li>
                        <li><a href="https://plus.google.com/b/109447485563959028354/109447485563959028354/posts" class="icon fa-google-plus"><span class="label">Google+</span></a></li>
                        <li><a href="https://github.com/Geo-Developers" class="icon fa-github"><span class="label">Github</span></a></li>
                        <li><a href="http://www.meetup.com/es/Geo-Developers/" class="icon fa-users"><span class="label">Meetup</span></a></li>
                        <li><a href="http://eepurl.com/br1h59" class="icon fa-envelope-o"><span class="label">Mailchimp</span></a></li>
                        <!--
                        <li><a href="#" class="icon fa-rss"><span>RSS</span></a></li>
                        <li><a href="#" class="icon fa-instagram"><span>Instagram</span></a></li>
                        <li><a href="#" class="icon fa-foursquare"><span>Foursquare</span></a></li>
                        <li><a href="#" class="icon fa-skype"><span>Skype</span></a></li>
                        <li><a href="#" class="icon fa-soundcloud"><span>Soundcloud</span></a></li>

                        <li><a href="#" class="icon fa-blogger"><span>Blogger</span></a></li>
                        <li><a href="#" class="icon fa-flickr"><span>Flickr</span></a></li>
                        <li><a href="#" class="icon fa-vimeo"><span>Vimeo</span></a></li>
                        -->
                    </ul>
                    <hr />
                </div>
            </div>
        </div>
        <footer>
            <ul id="copyright">
                <li><img src="http://mirrors.creativecommons.org/presskit/buttons/88x31/png/by-nc-sa.png" class="creative-commons"> GeoDevelopers.org</li>
                <li>Comunidad apoyada por: <a href="http://www.esri.es">Esri España</a>, <a href="http://www.kunlabori.es">KUNlabori</a> y <a href="http://www.lunacloud.com/">Lunacloud</a></li>
                <li>Diseño: <a href="http://html5up.net">HTML5 UP</a></li>
            </ul>
        </footer>
    </article>
</div>

<div id="cookies">
    <p>Al cerrar esta ventana aceptas nuestra <a href="{$ROOT}terminos-legales">política de cookies.</a><span onclick="closeCookies()" class="close">X</span></p>
</div>
<div class="geodev-academy" id="newsletter-footer">
    {include file="blocks/newsletter.tpl"}
</div>

<!-- Scripts -->
<script data-main="{$ROOT}assets/js/common.js" src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.18/require.min.js"></script>

{if isset($USER) == false}
    {include file="blocks/modal-login.tpl"}
{/if}