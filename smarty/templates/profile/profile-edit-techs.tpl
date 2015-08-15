<div class="row">
    <p class="strong col-md-12 uppercase text-center">Relacionados con el GeoDesarrollo</p>
</div>
{if $SKILLSGIS|@count == 0}
    <p>No se ha especificado ninguno</p>
{else}
    <div class="row">
        <table class="table text-center table-hover mb0">
            <thead>
            <tr>
                <th class="text-left">Tecnología</th>
                <th class="text-center">Interesado <i class="fa fa-info-circle" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Si te gustaría aprender pero aún no sabes casi nada o nada"></i></th>
                <th class="text-center">Básico</th>
                <th class="text-center">Medio</th>
                <th class="text-center">Medio-Alto</th>
                <th class="text-center">Avanzado</th>
            </tr>
            </thead>
            <tbody>
            {for $I=0 to $SKILLSGIS|@count -1}
                <tr>
                    <td class="text-left">
                        <div class="truncate" >
                            <a href="{$ROOT}miembros/?tech={$SKILLSGIS[$I]["name"]}" data-toggle="tooltip" data-placement="right" title="{$SKILLSGIS[$I]["desc"]}">
                                {$SKILLSGIS[$I]["name"]}
                            </a>
                        </div>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLSGIS[$I]["id"]}]" value="1" {if $SKILLSGIS[$I]["level"]==1}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLSGIS[$I]["id"]}]" value="2" {if $SKILLSGIS[$I]["level"]==2}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLSGIS[$I]["id"]}]" value="3" {if $SKILLSGIS[$I]["level"]==3}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLSGIS[$I]["id"]}]" value="4" {if $SKILLSGIS[$I]["level"]==4}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLSGIS[$I]["id"]}]" value="5" {if $SKILLSGIS[$I]["level"]==5}checked="checked"{/if}>
                    </td>
                </tr>
            {/for}

            </tbody>
        </table>

        <div class="form-group pt0 col-md-12">
            Añadir
            <div id="input-container">
                <div class="input-group">
                <input name="tech" type="text" autocomplete="off" id="search" class="form-control" data-provide="typeahead" value="" placeholder="P.e: ArcGIS, Google Maps, Leaflet, etc">
                <span class="input-group-btn pull-left">
                    <button class="btn btn-default" type="button"><i class="fa fa-plus"></i></button>
                </span>
                </div>
            </div>
        </div>
    </div>
{/if}

<div class="row">

    <p class="strong col-md-12 uppercase text-center">Otros:</p>
</div>


{if $SKILLS|@count == 0}
    <p>No se ha especificado ninguno</p>
{else}
    <div class="row">
        <table class="table text-center table-hover">
            <thead>
            <tr>
                <th class="text-left">Tecnología</th>
                <th class="text-center">Interesado  <i class="fa fa-info-circle" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Si te gustaría aprender pero aún no sabes casi nada o nada"></i></th>
                <th class="text-center">Básico</th>
                <th class="text-center">Medio</th>
                <th class="text-center">Medio-Alto</th>
                <th class="text-center">Avanzado</th>
            </tr>
            </thead>
            <tbody>
            {for $I=0 to $SKILLS|@count -1}
                <tr>
                    <td class="text-left">
                        <div class="truncate" >
                            <a href="{$ROOT}miembros/?tech={$SKILLS[$I]["name"]}" data-toggle="tooltip" data-placement="right" title="{$SKILLS[$I]["desc"]}">
                                {$SKILLS[$I]["name"]}
                            </a>
                        </div>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLS[$I]["id"]}]" value="1" {if $SKILLS[$I]["level"]==1}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLS[$I]["id"]}]" value="2" {if $SKILLS[$I]["level"]==2}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLS[$I]["id"]}]" value="3" {if $SKILLS[$I]["level"]==3}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLS[$I]["id"]}]" value="4" {if $SKILLS[$I]["level"]==4}checked="checked"{/if}>
                    </td>
                    <td>
                        <input type="radio" name="skills[{$SKILLS[$I]["id"]}]" value="5" {if $SKILLS[$I]["level"]==5}checked="checked"{/if}>
                    </td>
                </tr>
            {/for}
            </tbody>
        </table>
    </div>
{/if}

{literal}<script>{/literal}
var GEOSKILLS = [{for $I=0 to $NUMGEOSKILLS}"{$GEOSKILLS[$I]["name"]}",{/for}]
{literal}</script>{/literal}