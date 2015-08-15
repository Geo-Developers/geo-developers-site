<p class="strong mt2 uppercase">Relacionados con el GeoDesarrollo:</p>
{if $SKILLSGIS|@count == 0}
    <p>No se ha especificado ninguno</p>
{else}
    <ul class="row skills">
        {for $I=0 to $SKILLSGIS|@count -1}
            <li class="col-md-4">
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
            </li>
        {/for}
    </ul>
{/if}

<hr>

<p class="strong mt2 uppercase">Otros:</p>
<ul class="row">
    {if $SKILLS|@count == 0}
        <p>No se ha especificado ninguno</p>
    {else}
        {for $I=0 to $SKILLS|@count -1}
            <li class="col-md-4">
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
            </li>
        {/for}
    {/if}
</ul>
