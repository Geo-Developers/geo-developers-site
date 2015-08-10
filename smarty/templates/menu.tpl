<!-- Nav -->
<nav id="nav">
    <ul class="container">
        <li class="logo"><a href="{$ROOT}"><img src="{$ROOT}images/geodevelopers-logo.png"></a></li>
        <!--<li><a href="{$ROOT}tutoriales">Tutoriales</a></li>-->
        <li><a href="{$ROOT}webinars">Webinars</a></li>
        <li><a href="{$ROOT}academy">Academy</a></li>
        <li><a href="{$ROOT}miembros">Miembros</a></li>
        <li><a href="{$ROOT}recursos">Recursos</a></li>
        <li><a href="https://github.com/Geo-Developers">Proyectos</a></li>
        <li>
            {if isset($USER["logged"])}
                <div class="dropdown" id="login">
                    <div class="dropdown-toggle" id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img src="{$USER["photo_url"]}">
                        <span class="caret"></span>
                    </div>
                    <ul class="dropdown-menu" aria-labelledby="dLabel">
                        <li><a href="{$ROOT}avisos"><i class="glyphicon glyphicon-bell"></i> Avisos</a></li>
                        <li><a href="{$ROOT}miembros/{$USER["meetup_id"]}"><i class="glyphicon glyphicon-user"></i> Perfil</a></li>
                        <li><a href="{$ROOT}logout"><i class="glyphicon glyphicon-log-out"></i> Cerrar sesión</a></li>
                    </ul>
                </div>
            {/if}

        </li>
        <!--<li><a href="{$ROOT}nosotros">Sobre nosotros</a></li>-->
    </ul>
</nav>