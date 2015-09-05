<!DOCTYPE HTML>
<html>
<head>
    {include file="header.tpl" title="Preferencias - Geo Developers"}
</head>
<body id="notifications">
{include file="menu.tpl"}
<div id="main-wrapper">
    <div class="container">
        <div class="row">
            <div class="col-md-12 ">


                <div class="row">
                    <div class="col-md-12" style="margin-bottom:20px">
                        <a href="{$ROOT}">Home</a> &gt; Preferencias
                    </div>
                </div>

                {include file="blocks/preferences.tpl"}
            </div>

        </div>
    </div>


    {include file="footer.tpl"}
    {literal}
    <script>
        require([
            'jquery',
            'base',
            'cookies'
        ],function($, base, Cookies ){
            base.init(Cookies);

            $("#preferences").on( "submit", function( event ) {
                event.preventDefault();

                var that = this;
                $(this).find("i").addClass("fa-circle-o-notch fa-spin");

                $.ajax({
                    type: "POST",
                    url: GEODEV.rootpath + "api/user/" + USER["meetup_id"] + "/preferences",
                    data: $( this ).serialize(),
                    dataType: 'json',
                    success: function (r) {
                        $(that).find("i").removeClass("fa-circle-o-notch fa-spin");
                        if (r.status !== "success") {
                            alert("Error: " + r.message);
                        } else {
                            $el = $("#preferences-msg");
                            $el.fadeIn();
                            setTimeout(function(){$el.fadeOut()}, 6000);
                            $el.text(r.message);
                        }
                    }
                });
            });

        });
    </script>
    {/literal}
</div>
</body>
</html>

