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
    <p class="strong uppercase col-md-12">Relacionados con el GeoDesarrollo:</p>
    {if $SKILLSGIS|@count == 0}
        <p class="col-md-12">No se ha especificado ninguno</p>
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
                            <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                                 style="
                                 {if $SKILLSGIS[$I]["level"] == 0 } width: 10%;{/if}
                                 {if $SKILLSGIS[$I]["level"] == 1 } width: 25%;{/if}
                                 {if $SKILLSGIS[$I]["level"] == 2 } width: 50%;{/if}
                                 {if $SKILLSGIS[$I]["level"] == 3 } width: 75%;{/if}
                                 {if $SKILLSGIS[$I]["level"] == 4 } width: 100%;{/if}
                                         "
                                    >
                                {if $SKILLSGIS[$I]["level"] == 0 } ?{/if}
                                {if $SKILLSGIS[$I]["level"] == 1 } Básico{/if}
                                {if $SKILLSGIS[$I]["level"] == 2 } Medio{/if}
                                {if $SKILLSGIS[$I]["level"] == 3 } Avanzado{/if}
                                {if $SKILLSGIS[$I]["level"] == 4 } Experto{/if}
                            </div>
                        </div>
                    </div>
                {/for}
            </div>
        </div>
    {/if}
    <div class="col-md-12 pt0">
        <p class="strong uppercase">Otros:</p>
    </div>
    <div class="col-md-12 pt0">
        {if $SKILLS|@count == 0}
            <p>No se ha especificado ninguno</p>
        {else}
            <div class="row">
            {for $I=0 to $SKILLS|@count -1}
                <div class="col-md-4">
                    <a class="truncate" title="{$SKILLS[$I]["name"]}"
                       href="{$ROOT}miembros/?tech={$SKILLS[$I]["name"]}">
                        {$SKILLS[$I]["name"]}
                    </a>
                    <div class="progress">
                        <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"
                             style="
                             {if $SKILLS[$I]["level"] == 0 } width: 10%;{/if}
                             {if $SKILLS[$I]["level"] == 1 } width: 25%;{/if}
                             {if $SKILLS[$I]["level"] == 2 } width: 50%;{/if}
                             {if $SKILLS[$I]["level"] == 3 } width: 75%;{/if}
                             {if $SKILLS[$I]["level"] == 4 } width: 100%;{/if}
                                     "
                                >
                            {if $SKILLS[$I]["level"] == 0 } ?{/if}
                            {if $SKILLS[$I]["level"] == 1 } Básico{/if}
                            {if $SKILLS[$I]["level"] == 2 } Medio{/if}
                            {if $SKILLS[$I]["level"] == 3 } Avanzado{/if}
                            {if $SKILLS[$I]["level"] == 4 } Experto{/if}
                        </div>
                    </div>
                </div>
            {/for}
            </div>
        {/if}
    </div>
</div>