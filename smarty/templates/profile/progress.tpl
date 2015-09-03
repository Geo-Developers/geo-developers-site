<div class="row box mb3 text-center">
    <p class="text-label">Eficacia del perfil</p>

    {literal}<script type="text/javascript" src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1.1','packages':['corechart']}]}"></script>{/literal}

    <div id="donut_single" style="width: 180px; height: 180px;padding:0;margin: 0 45px 15px;" rel="popover"></div>
    <div style="display: none">
        <div id="donut_info">
            <div style="font-size: .9em">
                <p style="margin-bottom: 0"><strong>¿Qué indica la eficacia del perfil?</strong></p>
                <p>Indica la visibilidad que tiene el perfil dentro de la página.
                    Aumentando la eficacia se mejora la posibilidad de que cualquier
                    visitante de la página encuentre el perfil.</p>
                <p>Para calcular la eficacia de un perfil se tienen en cuenta si el usuario a indicado:<br>
                    1) Conocimientos GIS y no GIS<br>
                    2) Nivel <u>en todos</u> los conocimientos<br>
                    3) Bio, Profesión, Cargo y Estudios<br>
                    4) Perfiles sociales (Twitter y Linkedin)<br>
                </p>
            </div>
        </div>
    </div>
    {if $PROFILE["progress"] == 100}
        <div id="progress-100">100%</div>
    {/if}

    {literal}<script>{/literal}
        google.setOnLoadCallback(drawChart);
        function drawChart() {

            var data = google.visualization.arrayToDataTable([
                ['Effort', 'Amount given'],
                ['Completado',     {$PROFILE["progress"]}],
                ['Pendiente',     100-{$PROFILE["progress"]}],
            ]);

            var options = {
                pieHole: 0.5,
                pieSliceTextStyle: {
                    color: 'white'
                },
                'chartArea': {
                    'width': '100%',
                    'height': '100%'
                },
                legend: 'none',
                enableInteractivity: false
            };

            var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
            chart.draw(data, options);
        }
    {literal}</script>{/literal}


    {if $ACTION == "view"}
        {if isset($USER["id"]) && $USER["id"]==$PROFILE["id"]}
            <a href="{$ROOT}members/{$USER["meetup_id"]}/edit" class="btn btn-primary btn-block mb1">Editar perfil</a>
        {else}
            <p>
                <small>
                    {if isset($USER["email"]) == false}
                        ¿Eres tú?, puedes <a href="#">completarlo ahora</a>; o si sabes quién es <a href="#">puedes avísarle</a>.
                    {else}
                        <!-- TODO: Avisar a alguien de su perfil
                        Si sabes quién es <a href="#">puedes avísarle</a>.

                        -->
                    {/if}
                </small>
            </p>
        {/if}
    {/if}
</div>