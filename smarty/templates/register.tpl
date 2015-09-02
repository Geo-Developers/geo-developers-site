<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="register-page">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<div id="main-wrapper">
    <div class="row">
        <div class="
            {if !isset($USER["joined"])}
                col-xs-offset-2 col-md-8 pt0
            {else}
                col-xs-offset-4 col-md-4 pt0
            {/if}

        ">
            <h1 class="mb05 text-center">
                <img src="{if isset($USER["photo_url"])}{$USER["photo_url"]}{else}{$SESSION['photo_url']}{/if}"
                     alt="User photo"
                     class="img-thumbnail"
                     style="max-height: 50px;margin-top: -8px;margin-right: 10px;"
                        >
                Último paso
            </h1>
            <form action="." method="POST" class="box text-left" {if !isset($USER["joined"]) || $USER["joined"] == null }onsubmit="return validateForm()"{/if}>
                <div class="row">
                    <div class="
                        {if !isset($USER["joined"]) || $USER["joined"] == null }
                        col-md-6
                        {else}
                        col-md-12
                        {/if}
                    ">

                        <div class="form-group">
                            <label for="email" class="control-label">Email*:</label>
                            <input type="email"  id="email" name="email" class="form-control" style="color:rgb(85, 85, 85);" autofocus required="required"
                                   rel="popover" data-state="open" data-trigger="focus" data-placement="bottom" data-content="<div class='text-center small'><span class='underline'>Meetup no nos lo facilita</span> y lo necesitamos para que siempre puedas mantener tu perfil (aunque elimases tu cuenta de Meetup)</div>"
                            >
                        </div>

                        <div class="form-group">
                            <label for="name" class="control-label">Nombre*:</label>
                            <input type="type"
                                   value="{if $USER["name"]}{$USER["name"]}{else}{$SESSION['meetup_member']['name']}{/if}"
                                   id="name"
                                   name="name"
                                   class="form-control"
                                   required="required"
                             >
                        </div>

                        <div class="form-group">
                            <label for="name" class="control-label">Apellidos:</label>
                            <input type="type"
                                   value=""
                                   id="last_name"
                                   name="last_name"
                                   class="form-control"
                                   required="required"
                            >
                        </div>
                    </div>

                    {if !isset($USER["joined"]) || $USER["joined"] == null }
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="name" class="control-label">Perfil de Linkedin:</label>
                                <input type="type"
                                       value=""
                                       id="linkedin_url"
                                       name="linkedin_url"
                                       class="form-control"
                                >
                            </div>

                            <div class="form-group">
                                <label for="name" class="control-label">¿Qué tecnologías GIS conoces o te interesan?*:</label>
                                <div class="input-group skillList" id="skillList">
                                    <select class="form-control pull-left" id="inputGeoSkill">
                                        {for $I=0 to $GEOSKILLS|@count-1 }
                                            <option value="{$GEOSKILLS[$I]["name"]}">{$GEOSKILLS[$I]["name"]}</option>
                                        {/for}
                                    </select>
                                    <span class="input-group-btn pull-left">
                                        <button class="btn btn-primary" type="button"><i class="fa fa-plus disabled"></i></button>
                                    </span>
                                </div>
                                <ul class="skills inline mt1"></ul>
                            </div>
                        </div>
                    {/if}
                </div>
                <!-- TODO: Add last name input -->
                <input type="submit" value="Terminar" class="btn btn-primary btn-block mt0 pt05 pb05 mt1 " style="margin: 0;">

            </form>
        </div>

    </div>
    {include file="footer.tpl"}
</div>
{literal}
<script id="skillTmpl" type="text/x-jsrender">
    <li data-skill="{{:skill_name}}" onclick="removeSkill(this)">
        {{:skill_name}}
        <input type="hidden" name="skills[]" value="{{:skill_name}}">
        <i class="fa fa-times"></i>
    </li>
</script>
{/literal}
<script>
    require(['common'], function(){
        require([
            'register',
            'jquery'
        ],function(register,$){
            register.init();
        });

    });
</script>
</body>
</html>

