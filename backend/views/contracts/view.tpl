{include file="layouts/header.tpl"}
<!-- page content -->
    <div class="col-md-6">
    <h3>View contract data</h3>
        
        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Car Number</label>
                <div class="input-group ui-widget">
                  <input type="text" id="car_number" name="car_number" value="{$data.car_number}"  class="form-control" disabled=1>
                  <span class="input-group-addon"><i class="fa fa-car"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Mileage</label>
                <div class="input-group">
                    <input type="text" id="mileage" name="car_mileage" value="{$data.car_mileage}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-bug"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Data of Start</label>
                <div class="input-group">
                    <input name="date_start" class="datepicker form-control" value="{$contract->date_start}" type="text" disabled=1/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div> 
            <div class="col-xs-6 col-md-6">
                <label>Data of Finish</label>
                <div class="input-group">
                    <input name="date_stop" class="datepicker form-control" value="{$contract->date_stop}" type="text" disabled=1/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Time</label>
                <div class="input-group">
                    <input type="text" name="time" value="{$contract->time}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Client Passport #</label>
                <div class="input-group">
                    <input type="text" id="passport" name="passport" value="{$client->passport}" class="form-control" disabled=1>
                    <input type="hidden" name="client_id">
                    <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
                </div>  
            </div> 
            <div class="col-xs-6 col-md-6">
                <label>Client Name</label>
                <div class="input-group">
                    <input type="text" id="s_name" name="s_name" value="{$client->s_name}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Nationality</label>
                <div class="input-group">
                    <input type="text" name="nationality" value="{$client->nationality}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-flag"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone Russia</label>
                <div class="input-group">
                    <input type="text" id="phone_h" name="phone_h" value="{$client->phone_h|default:"+7"}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone Thailand</label>
                <div class="input-group">
                    <input type="text" id="phone_m" name="phone_m" value={$client->phone_m|default:"+66"} class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>E-mail</label>
                <div class="input-group">
                    <input type="text" id="email" name="email" value="{$client->email|default:"@gmail.com"}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Client Type</label>
                <select class="form-control system-add-price" name="client_type" disabled=1>
                    <option value="pauper">Pauper</option>
                    <option value="middle">Middle</option>
                    <option value="rich">Rich</option>
                </select>
            </div>
            
            <div class="col-xs-6 col-md-6">
                <label>Status</label>
                <div>{$contract->getStatusName()}</div>
            </div>
            
        </div>    

    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
      </ol>

      <!-- Wrapper for slides -->
      <div class="carousel-inner" role="listbox">
        {foreach $contract->getPhotos() as $num=>$photo}
          <div class="item {if $photo@iteration==1}active{/if}">
            <img src="{$data.path}{$photo}" />
          </div>
        {/foreach}
      </div>

      <!-- Controls -->
      <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>

        <div><a href="#" onClick="history.go(-1)"><strong>Back</strong></a></div>
    </div>

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