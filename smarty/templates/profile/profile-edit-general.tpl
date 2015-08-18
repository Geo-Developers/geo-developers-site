<div class="row">
    <div class="col-md-12">
        <p class="row">
            <span class="text-label col-md-2 pt05">Nombre:</span>
                <span class="col-md-10 pt05">
                    <input class="form-control" value="{$PROFILE["name"]}" name="name" type="text">
                </span>
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Apellidos:</span>
                <span class="col-md-10 pt05">
                    <input class="form-control" value="{$PROFILE["last_name"]}" name="last_name" type="text">
                </span>
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Email: <i class="fa fa-info-circle onright" data-toggle="tooltip" data-placement="right" title="" data-original-title="Tu dirección de email será privada y se usará en función de las preferencias que nos indiques"></i></span>
                <span class="col-md-10 pt05">
                    <input class="form-control" value="{$PROFILE["email"]}" name="email" type="email">
                </span>
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Foto:</span>
                <span class="col-md-10 pt05">
                    <input type="file" id="photo" name="photo">
                    <small class="help-block">
                        <span id="picture"><img src="{$PROFILE["photo_url"]}"></span>
                        Si seleccionas un archivo reemplazarás <a href="{$PROFILE["photo_url"]}">tu foto actual</a>.
                    </small>
                </span>
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Ubicación:</span>
                <span class="col-md-10 pt05">
                    <input class="form-control" value="{$PROFILE["location"]}" name="location">
                    <!--<small class="help-block">
                        Es probable que en un futuro integremos un buscador de profesionales
                        por localización, por lo que cuanto más preciso seas,más preciso será
                        el resultado.
                    </small>-->
                </span>
        </p>
        <p class="row">
            <span class="text-label col-md-2 pt05">Bio:</span>
                <span class="col-md-10 pt05">
                    <textarea class="form-control" name="bio">{$PROFILE["bio"]}</textarea>
                </span>
        </p>
        <p class="row">
                <span class="text-label col-md-2 pt05">
                    Área:
                    <i class="fa fa-info-circle onright" id="info-area" data-toggle="tooltip" data-placement="right" title="" data-original-title="Especifica en qué campo estás especializado. Por ejemplo: informática, geografía, geodesia, telecomunicaciones, cartografía, geomática, electrónica, montes, etc."></i>
                </span>
                <span class="col-md-10 pt05">
                    <input class="form-control focus" data-focus="#info-area" value="{$PROFILE["studies"]}" name="studies" id="studies" autocomplete="off" rel="popover" data-placement="top" title="Área de especialidad" data-content="Especifica en qué campo estás especializado. Por ejemplo: informática, geografía, geodesia, telecomunicaciones, cartografía, geomática, electrónica, montes, etc.">
                </span>
        </p>
        <p class="row">
                <span class="text-label col-md-2 pt05">
                    Situación
                </span>
                <span class="col-md-10 pt05">
                    <!-- select
                    <input class="form-control" value="{$PROFILE["position"]}" name="position" id="position">-->
                    <label class="checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox1" name="student" value="Estudiante"
                               {if $PROFILE["position"]|strpos:"Estudiante" !== false}checked="checked"{/if}> Estudiante
                    </label>
                    <label class="checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox2" name="unemployed" value="Desempleado"
                               {if $PROFILE["position"]|strpos:"Desempleado" !== false}checked="checked"{/if}> Desempleado
                    </label>
                    <label class="checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox3" name="freelance" value="Autónomo"
                               {if $PROFILE["position"]|strpos:"Autónomo" !== false}checked="checked"{/if}> Autónomo
                    </label>
                    <label class="checkbox-inline">
                        <input type="checkbox" id="inlineCheckbox3" name="worker" value="Trabajador por cuenta ajena"
                               {if $PROFILE["position"]|strpos:"Trabajador por cuenta ajena" !== false}checked="checked"{/if}> Trabajador por cuenta ajena
                    </label>
                </span>
        </p>
        <p class="row">
                <span class="text-label col-md-2 pt05">
                    Función:
                    <i class="fa fa-info-circle onright" id="info-funcion" data-toggle="tooltip" data-placement="right" title="" data-original-title="Desarrollador, jefe técnico, analista programador, consultor GIS, técnico GIS, investigador, profesor, director de departamento, etc."></i>
                </span>
                <span class="col-md-10 pt05">
                    <input class="form-control focus"  data-focus="#info-funcion"  value="{$PROFILE["occupation"]}" name="occupation" id="occupation" autocomplete="off" rel="popover" data-placement="top" title="¿Cual es tú función actualmente?" data-content="Desarrollador, jefe técnico, analista programador, consultor GIS, técnico GIS, investigador, profesor, director de departamento, etc.">
                </span>
        </p>
    </div>
</div>