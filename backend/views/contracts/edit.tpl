{include file="layouts/header.tpl"}
<!-- page content -->
<form action="" enctype="multipart/form-data" method="POST">
    <div class="col-md-6">
    <h3>Add or Edit Contract</h3>
        {if $error}
        <div class="alert alert-danger"><strong>ERROR!</strong> {$error}</div>
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
                    <input type="text" id="mileage" name="car_mileage" value="{$data.car_mileage}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-bug"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Data of Start</label>
                <div class="input-group">
                    <input id="date_start" name="date_start" class="datepicker form-control" value="{$contract->date_start}" type="text"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div> 
            <div class="col-xs-6 col-md-6">
                <label>Data of Finish</label>
                <div class="input-group">
                    <input id="date_stop" name="date_stop" class="datepicker form-control" value="{$contract->date_stop}" type="text"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Time</label>
                <div class="input-group">
                    <input type="text" name="time" value="{$contract->time}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Client Passport #</label>
                <div class="input-group">
                    <input type="text" id="passport" name="passport" value="{$customer->passport}" class="form-control">
                    <input type="hidden" name="client_id">
                    <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
                </div>  
            </div> 
            <div class="col-xs-6 col-md-6">
                <label>Client Name</label>
                <div class="input-group">
                    <input type="text" id="s_name" name="s_name" value="{$customer->s_name}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Nationality</label>
                <div class="input-group">
                    <input type="text" name="nationality" value="{$customer->nationality}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-flag"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone</label>
                <div class="input-group">
                    <input type="text" id="phone_h" name="phone_h" value="{$customer->phone_h|default:"+7"}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone</label>
                <div class="input-group">
                    <input type="text" id="phone_m" name="phone_m" value={$customer->phone_m|default:"+66"} class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>E-mail</label>
                <div class="input-group">
                    <input type="text" id="email" name="email" value="{$customer->email|default:"@gmail.com"}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                </div>
            </div>
        </div>    
        <div class="row">
            <div class="col-xs-6 col-md-3">
                <label>Amount THB</label>
                <div class="input-group">
                    <input type="text" name="amount_thb" value="" class="form-control">
                    <span class="input-group-addon">THB</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Amount USD</label>
                <div class="input-group">
                    <input type="text" name="amount_usd" value="" class="form-control">
                    <span class="input-group-addon">USD</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Amount EURO</label>
                <div class="input-group">
                    <input type="text" name="amount_euro" value="" class="form-control">
                    <span class="input-group-addon">EURO</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Amount RUB</label>
                <div class="input-group">
                    <input type="text" name="amount_ruble" value="" class="form-control">
                    <span class="input-group-addon">RUB</span>
                </div> 
            </div>

            <div class="col-xs-6 col-md-3">
                <label>Deposit THB</label>
                <div class="input-group">
                    <input type="text" name="deposit_thb" value="" class="form-control">
                    <span class="input-group-addon">THB</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Deposit USD</label>
                <div class="input-group">
                    <input type="text" name="deposit_usd" value="" class="form-control">
                    <span class="input-group-addon">USD</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Deposit EURO</label>
                <div class="input-group">
                    <input type="text" name="deposit_euro" value="" class="form-control">
                    <span class="input-group-addon">EURO</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Deposit RUB</label>
                <div class="input-group">
                    <input type="text" name="deposit_ruble" value="" class="form-control">
                    <span class="input-group-addon">RUB</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Add Files</label>
                <div class="input-group">
                    <label class="input-group-btn"><span class="btn btn-fill">Browse<input type="file" name="files[]" style="display: none;" multiple></span></label>
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
var cars = [
  {foreach $cars as $num=>$car}
    {literal}{{/literal} value: '{$car->number} ({$car->mark} {$car->model}, {$car->color})', data: '{$car->id}', mileage: '{$car->mileage}' {literal}}{/literal},
  {/foreach}
 ];

var clients_ids = [
  {foreach $customers as $num=>$customer}
    {literal}{{/literal} value: '{$customer->passport}', s_name: "{$customer->s_name}", nationality: '{$customer->nationality}', phone_m: '{$customer->phone_m}', phone_h: '{$customer->phone_h}', email: '{$customer->email}'{literal}}{/literal},
  {/foreach}
];

{literal}
     $('#car_number').autocomplete({
         source: cars,
         select: function (event, ui) {
                    $('#car_id').val(ui.item.data)
                    $('#mileage').val(ui.item.mileage)

                  }
     });
     
     $('#passport').autocomplete({
         source: clients_ids,
         select: function (event, ui) {
                    $('#client_id').val(ui.item.client_id)
                    $('#s_name').val(ui.item.s_name)
                    $('#email').val(ui.item.email)
                    $('#phone_m').val(ui.item.phone_m)
                    $('#phone_h').val(ui.item.phone_h)

                  }
     });
  </script>
  {/literal}