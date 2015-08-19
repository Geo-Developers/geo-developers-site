<div class="row">

    <div class="col-md-12">
        <div class="row" id="header">

            <span class="text-label col-md-2">
                <img src="{$PROFILE["photo_url"]}">
            </span>
            <div class="intro col-md-10">
                <h1 class="capitalize">{$PROFILE["name"]} {$PROFILE["last_name"]}</h1>
                {$PROFILE["location"]} | Miembro desde: {$PROFILE["joined"]}
            </div>

        </div>
        <p class="row">
            <span class="text-label col-md-2 pt05">Bio:</span>
                        <span class="col-md-10 pt05">{$PROFILE["bio"]|default:'No disponible'}
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Estudios:</span>
            <span class="col-md-10 pt05">{$PROFILE["studies"]|default:'Desconocidos'}</span>
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Situación:</span>
            <span class="col-md-10 pt05">{$PROFILE["position"]|default:'Desconocida'}</span>
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Profesión:</span>
            <span class="col-md-10 pt05">{$PROFILE["occupation"]|default:'Desconocida'}</span>
        </p>


        <div class="row">
            <span class="text-label col-md-2 pt05">Otros perfiles:</span>
            <ul class="inline col-md-10 pt05" id="social-networks">
                {if $PROFILE["twitter_url"]}
                    <li>
                        <a href='{$PROFILE["twitter_url"]}' class="icon twitter"
                           {if isset($PROFILE["twitter_name"])}title="{$PROFILE["twitter_name"]}"{else}Twitter{/if}
                           data-toggle="tooltip" data-placement="bottom">
                            <i class="fa fa-twitter"></i>
                            <span class="label">Twitter</span>
                        </a>
                    </li>
                {/if}
                {if $PROFILE["linkedin_url"]}
                    <li>
                        <a href='{$PROFILE["linkedin_url"]}' class="icon linkedin" title="Linkedin" data-toggle="tooltip" data-placement="bottom">
                            <i class="fa fa-linkedin"></i>
                            <span class="label">Linkedin</span>
                        </a>
                    </li>
                {/if}
                {if $PROFILE["github_url"]}
                    <li>
                        <a href='{$PROFILE["github_url"]}' class="icon github" title="Github" data-toggle="tooltip" data-placement="bottom">
                            <i class="fa fa-github"></i>
                            <span class="label">Github</span>
                        </a>
                    </li>
                {/if}
                {if $PROFILE["meetup_url"]}
                    <li>

                        <a href='{$PROFILE["meetup_url"]}' class="icon meetup" title="Meetup" data-toggle="tooltip" data-placement="bottom">
                            <i class="fa fa-users"></i>
                            <span class="label">Meetup</span>
                        </a>
                    </li>
                {/if}
                {if $PROFILE["facebook_url"]}
                    <li>
                        <a href='{$PROFILE["facebook_url"]}' class="icon facebook" title="Facebook" data-toggle="tooltip" data-placement="bottom">
                            <i class="fa fa-facebook"></i>
                            <span class="label">Facebook</span>
                        </a>
                    </li>
                {/if}
                {if $PROFILE["flickr_url"]}
                    <li>
                        <a href='{$PROFILE["flickr_url"]}' class="icon flickr" title="Flickr" data-toggle="tooltip" data-placement="bottom">
                            <i class="fa fa-flickr"></i>
                            <span class="label">Flickr</span>
                        </a>
                    </li>
                {/if}
            </ul>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <hr class="clearfix mt1">

        <h2>Conocimientos e intereses:</h2>
    </div>
    <div class="strong uppercase col-md-12 pt0"><p>Relacionados con el GeoDesarrollo:</p></div>
    {if $SKILLSGIS|@count == 0}
        <div class="col-md-12 pt0">
            <p>
                {if isset($USER["email"]) && $USER["email"]==$PROFILE["email"]}
                    No has especificado ninguno, <a href="{$PROFILE["meetup_id"]}/editar#tech" class="btn btn-primary">añadelos ahora</a>.
                {else}
                    No se ha especificado ninguno
                {/if}
            </p>
        </div>
    {else}
        <div class="col-md-12">
            <div class="row skills">
                {for $I=0 to $SKILLSGIS|@count -1}
                    <div class="col-md-4">
                        <div class="truncate" >
                            <a href="{$ROOT}miembros/?tech={$SKILLSGIS[$I]["name"]}" data-toggle="tooltip" data-placement="right" title="{$SKILLSGIS[$I]["desc"]}">
                                {$SKILLSGIS[$I]["name"]}
                            </a>
                        </div>
                        <div class="progress">
                            <div class="progress-bar"
                                 role="progressbar"
                                 aria-valuenow="60"
                                 aria-valuemin="0"
                                 aria-valuemax="100"
                                 data-level="{$SKILLSGIS[$I]["level"]}"
                            >
                                {if $SKILLSGIS[$I]["level"] == 0 } ?{/if}
                                {if $SKILLSGIS[$I]["level"] == 1 } {/if}
                                {if $SKILLSGIS[$I]["level"] == 2 } Básico{/if}
                                {if $SKILLSGIS[$I]["level"] == 3 } Medio{/if}
                                {if $SKILLSGIS[$I]["level"] == 4 } Medio-Alto{/if}
                                {if $SKILLSGIS[$I]["level"] == 5 } Avanzado{/if}
                            </div>
                        </div>
                    </div>
                {/for}
                {if isset($USER["email"]) && $USER["email"]==$PROFILE["email"]}
                    <div class="col-md-4">
                        <p style="margin-bottom: 5px;">Añade más conocimientos:</p>
                        <div class="btn-group-xs">
                            <a href="{$PROFILE["meetup_id"]}/editar#tech" class="btn btn-default btn-block">Editar mi perfil</a>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
    {/if}
    <div class="col-md-12 pt0">
        <p class="strong uppercase">Otros:</p>
    </div>
    <div class="col-md-12 pt0">
        {if $SKILLS|@count == 0}
            <div>
                <p>
                    {if isset($USER["email"]) && $USER["email"]==$PROFILE["email"]}
                        No has especificado ninguno, <a href="{$PROFILE["meetup_id"]}/editar#tech" class="btn btn-success">añadelos ahora</a>.
                    {else}
                        No se ha especificado ninguno
                    {/if}
                </p>
            </div>
        {else}
            <div class="row">
            {for $I=0 to $SKILLS|@count -1}
                <div class="col-md-4">
                    <a class="truncate" title="{$SKILLS[$I]["name"]}"
                       href="{$ROOT}miembros/?tech={$SKILLS[$I]["name"]}">
                        {$SKILLS[$I]["name"]}
                    </a>
                    <div class="progress">
                        <div class="progress-bar"
                             role="progressbar"
                             aria-valuenow="60"
                             aria-valuemin="0"
                             aria-valuemax="100"
                             data-level="{$SKILLS[$I]["level"]}"
                        >
                            {if $SKILLS[$I]["level"] == 0 } ?{/if}
                            {if $SKILLS[$I]["level"] == 1 } {/if}
                            {if $SKILLS[$I]["level"] == 2 } Básico{/if}
                            {if $SKILLS[$I]["level"] == 3 } Medio{/if}
                            {if $SKILLS[$I]["level"] == 4 } Medio-Alto{/if}
                            {if $SKILLS[$I]["level"] == 5 } Avanzado{/if}
                        </div>
                    </div>
                </div>
            {/for}
            {if isset($USER["email"]) && $USER["email"]==$PROFILE["email"]}
                <div class="col-md-4">
                    <p style="margin-bottom: 5px;">Añade más conocimientos:</p>
                    <div class="btn-group-xs">
                        <a href="{$PROFILE["meetup_id"]}/editar#tech" class="btn btn-warning btn-block">Editar mi perfil</a>
                    </div>
                </div>
            {/if}
            </div>
        {/if}
    </div>
</div>