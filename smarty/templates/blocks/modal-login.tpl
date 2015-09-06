{if isset($USER) == false}

    <div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!--<h4 class="modal-title" id="myModalLabel">Esta acción requiere estar identificado</h4>-->
                </div>
                <div class="modal-body">
                    <a href="{$ROOT}login/login.php?returnURL={$returnURL}" class="btn btn-lg" id="login-btn"><img src="{$ROOT}images/meetup.png"> Entrar ahora</a>
                    <p class="text-center small msg" style="">Para poder acceder a tu perfil y a la sección de vídeos es necesario identificarse con tu cuenta de Meetup y autorizar la aplicación.</p>
                </div>
                <div class="modal-footer">

                    <!--<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>-->
                </div>
            </div>
        </div>
    </div>
{/if}