<form action="." method="POST" class="box text-left" id="preferences">
    {for $I=0 to $GROUPINGS|@count-1}
        <div data-grouping="{$GROUPINGS[$I]["id"]}" class="row mb1 grouping">
            <p class="col-md-12 pt1">{$GROUPINGS[$I]["name"]} <i class="fa pull-right"></i></p>
            <input type="hidden" name="groups[]" value="{$GROUPINGS[$I]["id"]}">
            <div class="options">
            {for $J=0 to {$GROUPINGS[$I]["count"]}}
                <div class="col-md-6 pt0">
                    <label>
                        <input type="checkbox"
                               value="{$GROUPINGS[$I]["groups"][$J]["name"]}"
                               name="{$GROUPINGS[$I]["id"]}[]"
                                {if isset($INTERESTS[{$GROUPINGS[$I]["groups"][$J]["name"]}])}
                                    checked="checked"
                                {/if}
                                >
                        {$GROUPINGS[$I]["groups"][$J]["name"]}
                    </label>
                </div>
            {/for}
            </div>
        </div>
    {/for}
    <button class="btn btn-primary btn-block" style="margin:0"  mp-name="Click suscribe confirm">Actualizar <i class="fa"></i></button>
    <div class="alert alert-success mt1 text-center mb05" style="display:none" id="preferences-msg"></div>
</form>