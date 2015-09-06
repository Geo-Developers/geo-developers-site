<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Seminarios online y gratuitos - Geo Developers"}
    <meta name="description" content="Únete a los seminarios online de la comunidad" />
</head>
<body class="video-list" id="webinars">
{include file="menu.tpl"}
<div id="main-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-md-12" style="margin-bottom: 20px">
                <a href="../">Home</a> &gt;

                <a href="{$ROOT}academy">
                    Eventos y vídeos
                </a>
                &gt;
                Próximos eventos
            </div>
        </div>
    </div>


    <div class="container">
        <div class="row" id="video-list">
            {for $I=0 to $WEBINARS|@count-1}
                <div class="col-md-4">
                    <article class="box style2">
                        <a href="{$WEBINARS[$I]["youtubeId"]}" class="image featured">
                            <img src="{$ROOT}images/webinar.jpg" alt="" />
                        </a>
                        <div class="table">
                            <p>{$WEBINARS[$I]["title"]}</p>
                        </div>
                    </article>
                </div>
            {/for}
        </div>
    </div>

    {include file="footer.tpl"}
</div>
<script>
    require([
        'jquery',
        'academy'
    ],function($, academy){
        academy.init("webinars");
    });
</script>
</body>
</html>