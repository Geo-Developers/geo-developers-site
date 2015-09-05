<div class="row box mb3 text-center recommendations pb2" id="referrers">
    {if $REFERRERS|@count == 0 && isset($USER["email"]) && $USER["email"]==$PROFILE["email"]}
        <p class="text-label col-md-12 mt1 title">Recomendaciones <i class="fa fa-thumbs-o-up"></i></p>
        <p>
            <small>
                Aún no has recibido ninguna recomendación.
            </small>
        </p>
        <p>
            <small>
                ¿Por qué no le echas un poquillo'
                de morro y le haces una
                "<i rel="popover" data-img="{$ROOT}images/gato_de_srek.gif" style="color:#337ab7;cursor:pointer;text-decoration: underline">kindly suggestion</i>"
                a los <a href="{$ROOT}members">miembros de la comunidad</a> con los
                que tengas confianza?.<br>
            </small>
        </p>
        <p>
            <small>
                Te ayudará a ganar visibilidad en
                <a href="{$ROOT}members/rankings/">el ranking</a>. <i class="fa fa-smile-o"></i>
            </small>
        </p>

    {/if}
    <p class="text-label col-md-12 mt1 title" style="{if $REFERRERS|@count == 0}display:none;{/if}">
        Recomendado por
    </p>
    <div class="col-md-12 pt0 text-center">
        {for $J=0 to $REFERRERS|@count-1}
            <div class="referrer" data-referrer="{$REFERRERS[$J]["meetup_id"]}">
                <a href="{$ROOT}members/{$REFERRERS[$J]["meetup_id"]}"  class="image-wrapper">
                    <span class="picture clearfix" style="background-image: url('{$REFERRERS[$J]["photo_url"]}')"></span>
                </a>
            </div>
        {/for}

        {if isset($USER)}
            <div class="referrer" data-referrer="{$USER["meetup_id"]}" style="display:none;">
                <a href="{$ROOT}members/{$USER["meetup_id"]}" class="image-wrapper">
                    <span class="picture clearfix" style="background-image: url('{if isset($USER["photo_url"])}{$USER["photo_url"]}{else}{$SESSION['photo_url']}{/if}')"></span>
                </a>
            </div>
        {/if}
    </div>


    <div class="col-md-12" style="{if isset($USER) && $USER["email"]==$PROFILE["email"]}display:none{/if}">
        <p class="pb0">
            {literal}<script>{/literal}
            var refered = {$PROFILE["meetup_id"]};
            {literal}</script>{/literal}
            <a href="#"
               class="  btn btn-block
                                    {if {$ISRECOMMENDED}}recommended btn-danger{else}btn-primary{/if}
                                    {if isset($USER) && $USER["email"]==$PROFILE["email"]}disabled{/if}
                                 "
               id="vote"
               {if !isset($USER)}data-toggle="modal" data-target="#loginModal"{/if}

                    >
                <i class="fa fa-times"></i>
                <i class="fa fa-thumbs-o-up"></i> Recomendar
            </a>
        </p>
        <!-- TODO: Modal con formulario de contacto -->
        <!--
                    <p class="pb0 pt05">
                        <a href="#" class="btn btn-block
                            {if isset($USER["id"]) && $USER["id"]==$PROFILE["id"]}
                                btn-danger"
                            {else}
                               disabled btn-default" title="No tenemos sus datos de contacto"
                            {/if}
                        >

                        <i class="fa fa-envelope-o"></i> Contactar
                        </a>
                    </p>
                    -->
    </div>

</div>