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
                <th class="text-left">&nbsp;</th>
                <th class="text-center">Interesado <i class="fa fa-info-circle" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Si te gustaría aprender pero aún no sabes casi nada o nada"></i></th>
                <th class="text-center">Básico</th>
                <th class="text-center">Medio</th>
                <th class="text-center">Medio-Alto</th>
                <th class="text-center">Avanzado</th>
            </tr>
            </thead>
            <tbody id="geoSkillTable" class="small">
            {for $I=0 to $SKILLSGIS|@count -1}
                <tr id="skill_{$SKILLSGIS[$I]["id"]}">
                    <td class="text-left">
                        <div class="truncate" >
                            <i class="fa fa-times" onclick="removeSkill({$SKILLSGIS[$I]["id"]}, '#skill_{$SKILLSGIS[$I]["id"]}')"></i>
                            {$SKILLSGIS[$I]["name"]}
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

        <div class="form-group pt0 col-md-6">
            Añadir
            <div id="input-container">
                <div class="input-group">
                <input name="tech" type="text" autocomplete="off" id="geoskill" class="form-control" data-provide="typeahead" value="" placeholder="P.e: ArcGIS, Google Maps, Leaflet, etc">
                <span class="input-group-btn pull-left">
                    <button class="btn btn-default addSkill" type="button"  data-target="#geoskill" data-isgis="true" data-table="#geoSkillTable"><i class="fa fa-plus disabled"></i></button>
                </span>
                </div>
            </div>
        </div>
        <div class="form-group pt0 col-md-6">
            ¿Necesitas inspiración?, ten un listado:
            <div id="input-container">
                <div class="input-group" id="skillList">
                    <select class="form-control pull-left">
                        {for $I=0 to $GEOSKILLS|@count-1}<option>{$GEOSKILLS[$I]["name"]}</option>{/for}
                    </select>
                    <span class="input-group-btn pull-left">
                        <button class="btn btn-default" type="button" data-target="#geoskill"><i class="fa fa-plus disabled"></i></button>
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
                <th class="text-left">&nbsp;</th>
                <th class="text-center">Interesado  <i class="fa fa-info-circle" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Si te gustaría aprender pero aún no sabes casi nada o nada"></i></th>
                <th class="text-center">Básico</th>
                <th class="text-center">Medio</th>
                <th class="text-center">Medio-Alto</th>
                <th class="text-center">Avanzado</th>
            </tr>
            </thead>
            <tbody class="skills" id="skillTable">
            {for $I=0 to $SKILLS|@count -1}
                <tr id="skill_{$SKILLS[$I]["id"]}">
                    <td class="text-left">
                        <div class="truncate" >
                            <i class="fa fa-times" onclick="removeSkill({$SKILLS[$I]["id"]}, '#skill_{$SKILLS[$I]["id"]}')"></i>
                            {$SKILLS[$I]["name"]}

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

        <div class="form-group pt0 col-md-6">
            Añadir
            <div id="input-container">
                <div class="input-group">
                    <input name="tech" type="text" autocomplete="off" id="skill" class="form-control" data-provide="typeahead" value="" placeholder="Javascript, AngularJS, etc">
                    <span class="input-group-btn pull-left">
                        <button class="btn btn-default addSkill" type="button" data-target="#skill" data-isgis="false" data-table="#skillTable"><i class="fa fa-plus disabled"></i></button>
                    </span>
                </div>
            </div>
        </div>
    </div>
{/if}

{literal}<script>{/literal}
var GEOSKILLS = [{for $I=0 to $GEOSKILLS|@count-1}"{$GEOSKILLS[$I]["name"]}",{/for}]
{literal}</script>{/literal}

{literal}
    <script id="skillTmpl" type="text/x-jsrender">
        <tr id="skill_{{:id}}">
        <td class="text-left">
            <div class="truncate" >
                <i class="fa fa-times" onclick="removeSkill({{:id}}, '#skill_{{:id}}')"></i>
                {{:name}}
            </div>
        </td>
        <td>
            <input type="radio" name="skills[{{:id}}]" value="1">
        </td>
        <td>
            <input type="radio" name="skills[{{:id}}]" value="2">
        </td>
        <td>
            <input type="radio" name="skills[{{:id}}]" value="3">
        </td>
        <td>
            <input type="radio" name="skills[{{:id}}]" value="4">
        </td>
        <td>
            <input type="radio" name="skills[{{:id}}]" value="5">
        </td>
    </tr>
    </script>
{/literal}