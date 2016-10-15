<!-- Nav -->
<nav id="nav">
    <ul class="container">
        <li class="logo"><a href="{$ROOT}"><img src="{$ROOT}images/logogeodevblancoreducido.png"></a></li>
        <!--<li><a href="{$ROOT}tutoriales">Tutoriales</a></li>-->
        <li><a href="{$ROOT}">Inicio</a></li>
        <li><a href="{$ROOT}community">Comunidad</a></li>
        <li><a href="{$ROOT}members">Miembros</a></li>

        <li><a href="{$ROOT}academy">Eventos y vídeos</a></li>
        <li><a href="{$ROOT}jobs">Empleo</a></li>
        <!--<li><a href="{$ROOT}webinars">Webinars</a></li>-->
        {*<li><a href="{$ROOT}recursos">Recursos</a></li>*}
        <!--<li><a href="https://github.com/Geo-Developers">Proyectos</a></li>-->
        {if isset($SESSION["logged"])}
            <li>
                <div class="dropdown" id="loginBtn">
                    <div class="dropdown-toggle" id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <img src="{if isset($USER["photo_url"])}{$USER["photo_url"]}{else}{$SESSION['photo_url']}{/if}">
                        <span class="caret"></span>
                    </div>
                    <ul class="dropdown-menu" aria-labelledby="dLabel">
                        <li><a href="{$ROOT}members/{$USER["meetup_id"]}"><i class="glyphicon glyphicon-user"></i> Perfil</a></li>
                        <li><a href="{$ROOT}preferences"><i class="glyphicon glyphicon-cog"></i> Preferencias</a></li>
                        <li><a href="{$ROOT}logout/?returnURL={$returnURL}"><i class="glyphicon glyphicon-log-out"></i> Cerrar sesión</a></li>
                    </ul>
                </div>
            </li>
        {elseif !isset($USER)}
            <li class="btn-group-sm">
                <button class="btn btn-primary" data-toggle="modal" data-target="#loginModal">
                    Entrar <i class="fa fa-sign-in"></i>
                </button>
            </li>
        {/if}

        <!--<li><a href="{$ROOT}nosotros">Sobre nosotros</a></li>-->
    </ul>
</nav>
