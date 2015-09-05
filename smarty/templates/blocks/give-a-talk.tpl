<div class="modal fade" id="speak" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Beneficios de dar una charla</h4>
            </div>
            <div class="modal-body">
                <div class="small text-center">

                    <iframe width="420" height="265" src="https://www.youtube.com/embed/QxJIaUjONwU" frameborder="0" allowfullscreen></iframe>
                    <form id="giveATalk">
                    {if isset($SESSION["logged"]) === false}
                    <p>
                        <label>Email: </label>

                        <input type="email" class="form-control" style="width: 284px;margin: 0 auto;" name="email" required="required"/>

                    </p>
                    {/if}
                    <p class="text-center">
                        <button class="btn btn-warning" id="speakBtn" mp-name="Click talk confirm">Ok, contad conmigo para alguna charla <i class="fa fa-thumbs-o-up"></i></button>
                    </p>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>