{include file="layouts/header.tpl"}
<!-- page content -->
<form action="" enctype="multipart/form-data" method="POST">
    <div class="col-md-6">
    <h3>Closed Contract #13</h3>
        {if $error}
        <div class="alert alert-danger"><strong>ERROR!</strong> {$error}</div>
        {/if}
        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Nationality</label>
                <div class="input-group">
                    <input type="text" name="nationality" value="{$client->nationality}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-flag"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone Russia</label>
                <div class="input-group">
                    <input type="text" id="phone_h" name="phone_h" value="{$client->phone_h|default:"+7"}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone Thailand</label>
                <div class="input-group">
                    <input type="text" id="phone_m" name="phone_m" value={$client->phone_m|default:"+66"} class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>E-mail</label>
                <div class="input-group">
                    <input type="text" id="email" name="email" value="{$client->email|default:"@gmail.com"}" class="form-control">
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
var cars = [
  {foreach $cars as $num=>$car}
    {literal}{{/literal} value: '{$car->number} ({$car->mark} {$car->model}, {$car->color})', data: '{$car->id}', mileage: '{$car->mileage}' {literal}}{/literal},
  {/foreach}
 ];

var clients_ids = [
  {foreach $clients as $num=>$client}
    {literal}{{/literal} value: '{$client->passport}', s_name: "{$client->s_name}", nationality: '{$client->nationality}', phone_m: '{$client->phone_m}', phone_h: '{$client->phone_h}', email: '{$client->email}'{literal}}{/literal},
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