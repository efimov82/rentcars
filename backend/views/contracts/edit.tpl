            {include file="layouts/header.tpl"}
            <!-- page content -->
            <form action="" enctype="multipart/form-data" method="POST">
                <div class="col-md-6">
                <h3>Add or Edit Contract</h3>
                    {if $error}
                    <div class="alert-danger"><strong>ERROR!</strong> {$error}</div>
                    {/if}
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Car Number</label>
                            <div class="input-group ui-widget">
                              <input type="text" id="car_number" name="car_number" value="{$data.car_number}"  class="form-control">
                              <input type="hidden" id="car_id" name="car_id" value="">
                              <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div>  
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Mileage</label>
                            <div class="input-group">
                                <input type="text" id="mileage" value="" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-bug"></i></span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Data of Start</label>
                            <div class="input-group">
                                <input name="date_start" class="datepicker form-control" type="text"/>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div> 
                        <div class="col-xs-6 col-md-6">
                            <label>Data of Finish</label>
                            <div class="input-group">
                                <input name="date_stop" class="datepicker form-control" type="text"/>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Time</label>
                            <div class="input-group">
                                <input type="text" name="time" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                            </div>  
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Client Name</label>
                            <div class="input-group">
                                <input type="text" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                            </div>  
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Client Passport #</label>
                            <div class="input-group">
                                <input type="text" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
                            </div>  
                        </div> 
                        
                        <div class="col-xs-6 col-md-6">
                            <label>Nationality</label>
                            <div class="input-group">
                                <input type="text" value="RUS" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-flag"></i></span>
                            </div>  
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Phone</label>
                            <div class="input-group">
                                <input type="text" value="+7" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Phone</label>
                            <div class="input-group">
                                <input type="text" value="+66" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>E-mail</label>
                            <div class="input-group">
                                <input type="text" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Client Type</label>
                            <select class="form-control system-add-price" name="client_type">
                                <option value="pauper">Pauper</option>
                                <option value="middle">Middle</option>
                                <option value="rich">Rich</option>
                            </select>
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Amount THB</label>
                            <div class="input-group">
                                <input type="text" name="thb" value="" class="form-control">
                                <span class="input-group-addon">THB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Amount USD</label>
                            <div class="input-group">
                                <input type="text" name="usd" value="" class="form-control">
                                <span class="input-group-addon">USD</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Amount EURO</label>
                            <div class="input-group">
                                <input type="text" name="euro" value="" class="form-control">
                                <span class="input-group-addon">EURO</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Amount RUB</label>
                            <div class="input-group">
                                <input type="text" name="ruble" value="" class="form-control">
                                <span class="input-group-addon">RUB</span>
                            </div> 
                        </div>

                        <div class="col-xs-6 col-md-3">
                            <label>Deposit THB</label>
                            <div class="input-group">
                                <input type="text" name="thb" value="" class="form-control">
                                <span class="input-group-addon">THB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Deposit USD</label>
                            <div class="input-group">
                                <input type="text" name="usd" value="" class="form-control">
                                <span class="input-group-addon">USD</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Deposit EURO</label>
                            <div class="input-group">
                                <input type="text" name="euro" value="" class="form-control">
                                <span class="input-group-addon">EURO</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Deposit RUB</label>
                            <div class="input-group">
                                <input type="text" name="ruble" value="" class="form-control">
                                <span class="input-group-addon">RUB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Add Files</label>
                            <div class="input-group">
                                <label class="input-group-btn"><span class="btn btn-fill">Browse<input type="file" style="display: none;" multiple></span></label>
                                <input type="text" name="image1" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Status</label>
                            {html_options name="status" options=$contract->statuses selected=$contract->status class="form-control"}
                        </div>
                    </div>    
                    {include file='layouts/panel.tpl' id=$contract->id}
                </div>
            </form>
            
            <script>
            var countries = [
              {foreach $cars as $num=>$car}
                {literal}{{/literal} value: '{$car->number} ({$car->mark} {$car->model}, {$car->color})', data: '{$car->id}', mileage: '{$car->mileage}' {literal}}{/literal},
              {/foreach}
             ];
            
            {literal}
                 $('#car_number').autocomplete({
                     source: countries,
                     select: function (event, ui) {
                                $('#car_id').val(ui.item.data)
                                $('#mileage').val(ui.item.mileage)
            
                              }
                 });
              </script>
            {/literal}