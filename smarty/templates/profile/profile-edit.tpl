<div class="row">
    <div class="col-md-12">
        <h1>Edición de perfil</h1>
    </div>
</div>
<form action="{$ROOT}members/{$PROFILE["meetup_id"]}/edit" method="post" enctype="multipart/form-data">
    <ul id="tabs" class="tabs nav nav-tabs" data-tabs="tabs">
        <li class="active"><a href="#general" data-toggle="tab"><i class="fa fa-user"></i> General</a></li>
        <li><a href="#social" data-toggle="tab"><i class="fa fa-users"></i> Perfiles sociales</a></li>
        <li><a href="#tech" data-toggle="tab"><i class="fa fa-cogs"></i> Conocimientos</a></li>
    </ul>
    <div id="profile-content" class="tab-content clearfix">
        <div class="tab-pane active" id="general">
            {include file="profile/profile-edit-general.tpl"}
            <div class="row">
                <div class="col-md-12">
                <button type="submit" class="btn btn-primary btn-block" style="margin:0">Guardar</button>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="social">
            {include file="profile/profile-edit-social.tpl"}
            <div class="row">
                <div class="col-md-12">
                    <button type="submit" class="btn btn-primary btn-block" style="margin:0">Guardar</button>
                </div>
            </div>
        </div>
        <div class="tab-pane" id="tech">
            {include file="profile/profile-edit-techs.tpl"}
            <div class="row">
                <div class="col-md-12">
                    <button type="submit" class="btn btn-primary btn-block" style="margin:0">Guardar</button>
                </div>
            </div>

        </div>
    </div>
</form>

{literal}<script>{/literal}
var studies = ["Agronomos", "Ambientales", "Arqueología", "Arquitectura", "Arte", "Astronomía", "Biología", "Caminos", "Cartografía", "Criminología", "Dirección y administración de empresas", "Diseño", "Diseño industrial", "Económicas", "Electrónica", "Empresariales", "Estadística", "Física", "Forestal", "Geodesia", "Geografía", "Geología", "Geomática", "Historia", "Industriales", "Informática", "Marketing", "Matemáticas", "Medicina", "Montes", "Ninguno", "Óptica", "Periodismo", "Politicas", "Telecomunicaciones", "Telemática", "Topografía"];
var occupation = ["Desarrollador", "Jefe técnico", "Analista programador", "Consultor GIS", "Técnico GIS", "Investigador", "Profesor", "Director de departamento"];
{literal}</script>{/literal}