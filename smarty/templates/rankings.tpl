<!DOCTYPE HTML>
<html>
<head>
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300' rel='stylesheet' type='text/css'>
    {include file="header.tpl" title="Comunidad de Geo Developers"}
</head>
<body id="rankings-page">
{include file="menu.tpl" title="Comunidad de Geo Developers"}
<div class="container">
    <div class="row">
        <div class="col-md-12" style="margin-top: 70px;margin-bottom:20px;">
            <a href="../../">Home</a> &gt; <a href="{$ROOT}miembros">Miembros</a> &gt; Rankings
        </div>
    </div>

    <div id="content">
        <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
            <li class="active"><a href="#members" data-toggle="tab"><i class="fa fa-users"></i> Miembros</a></li>
            <li><a href="#tech" data-toggle="tab"><i class="fa fa-cogs"></i> Tecnologías</a></li>
        </ul>
        <div id="ranking-content" class="tab-content clearfix">
            <div class="tab-pane active" id="members">
                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">Top 20 - Recomendados <i class="fa fa-info-circle"></i> </div>
                        <table class="table text-center">
                            <thead>
                            <tr>
                                <th class="text-center">#</th>
                                <th>GeoDeveloper</th>
                                <th class="text-center"><i class="fa fa-thumbs-o-up"></i></th>
                            </tr>
                            </thead>
                            <tbody>
                            {for $I=0 to $NTOPOTHERS-1}
                                <tr>
                                    <td>{$I}</td>
                                    <td class="text-left">n.a.</td>
                                    <td>n.a.</td>
                                </tr>
                            {/for}
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">Top 20 - Giseros <i class="fa fa-info-circle"></i> </div>
                        <table class="table text-center">
                            <thead>
                            <tr>
                                <th class="text-center">#</th>
                                <th class="text-left">GeoDeveloper</th>
                                <th class="text-center"><i class="fa fa-map-o"></i></th>
                            </tr>
                            </thead>
                            <tbody>
                            {for $I=0 to $NTOPGISEROS-1}
                                <tr>
                                    <td>{$I}</td>
                                    <td class="text-left">
                                        <a href="{$ROOT}miembros/{$TOPGISEROS[$I]["meetup_id"]}" class="capitalize">
                                        <div class="image-wrapper">
                                            <div class="picture" style="background-image: url('{$TOPGISEROS[$I]["photo_url"]}')"></div>
                                        </div>
                                        {$TOPGISEROS[$I]["name"]}</a>
                                    </td>
                                    <td>{$TOPGISEROS[$I]["count"]}</td>
                                </tr>
                            {/for}
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">Top 20 - Curiosos <i class="fa fa-info-circle"></i> </div>
                        <table class="table text-center">
                            <thead>
                            <tr>
                                <th class="text-center">#</th>
                                <th class="text-left">GeoDeveloper</th>
                                <th class="text-center"><i class="fa fa-graduation-cap"></i></th>
                            </tr>
                            </thead>
                            <tbody>
                            {for $I=0 to $NTOPEXPERTS-1}
                                <tr>
                                    <td>{$I}</td>
                                    <td class="text-left">
                                        <a href="{$ROOT}miembros/{$TOPEXPERTS[$I]["meetup_id"]}" class="capitalize">
                                            <div class="image-wrapper">
                                            <div class="picture" style="background-image: url('{$TOPEXPERTS[$I]["photo_url"]}')"></div>
                                            </div>
                                            {$TOPEXPERTS[$I]["name"]}
                                        </a>
                                    </td>
                                    <td>{$TOPEXPERTS[$I]["count"]}</td>
                                </tr>
                            {/for}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="tab-pane" id="tech">



                <div class="col-md-offset-1 col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">Top 20 - GIS <i class="fa fa-map-o"></i> </div>
                        <table class="table text-center">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th class="text-left">Tecnología</th>
                                <th>Miembros</th>
                            </tr>
                            </thead>
                            <tbody>
                            {for $I=0 to $NTOPGIS-1}
                                <tr>
                                    <td>{$I}</td>
                                    <td class="text-left"><a href="../?tech={$TOPGIS[$I]["name"]}">{$TOPGIS[$I]["name"]}</a></td>
                                    <td>{$TOPGIS[$I]["count"]}</td>
                                </tr>
                            {/for}
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="col-md-offset-1 col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">Top 20 - Otras <i class="fa fa-globe"></i> </div>
                        <table class="table text-center">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th class="text-left">Tecnología</th>
                                <th>Miembros</th>
                            </tr>
                            </thead>
                            <tbody>
                            {for $I=0 to $NTOPOTHERS-1}
                                <tr>
                                    <td>{$I}</td>
                                    <td class="text-left"><a href="../?tech={$TOPOTHERS[$I]["name"]}">{$TOPOTHERS[$I]["name"]}</a></td>
                                    <td>{$TOPOTHERS[$I]["count"]}</td>
                                </tr>
                            {/for}
                            </tbody>
                        </table>
                    </div>
                </div>


            </div>

        </div>
    </div>
</div>

</div>
{include file="footer.tpl"}
<script>
    require([
        'jquery',
        'resources',
        'tab'
    ],function($, resources){
        resources.init();
        $('#tabs').tab();
    });
</script>

</body>
</html>