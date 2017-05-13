{include file="layouts/header.tpl"}
<!-- page content -->
<form action="/payments/save" method="POST">
  <input type="hidden" name="id" value="{$payment->id}">
    <div class="col-md-6">
        <h3>Add/Edit payment</h3>
        <div class="row">
            <div class="col-xs-6 col-md-6">
              <label>Car Number</label>
              <div class="input-group">
                <input type="text" id="car_number" name="car_number" value="{$payment->getCar()->number}" class="form-control">
                <input type="hidden" id="car_id" name="car_id" value="{$payment->getCar()->id}">
                <span class="input-group-addon"><i class="fa fa-car"></i></span>
              </div> 
            </div>
            <div class="col-xs-6 col-md-6">
              <label>Contract Number</label>
              <div class="input-group">
                <input type="text" name="contract_id" value="{$payment->contract_id}" class="form-control">
                <span class="input-group-addon"><i class="fa fa-car"></i></span>
              </div> 
            </div>
        </div>	
        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Category</label>
                {html_options name=category_id options=$categories selected=$payment->category_id class="form-control system-add-price"}
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Type</label>
                {html_options name="type_id" options=$types selected=$payment->type_id class="form-control system-add-price"}
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Date of Payment</label>
                <div class="input-group">
                    <input name="date" value="{$payment->date}" class="datepicker form-control" type="text" autocomplete="off"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Transaction Number</label>
                <div class="input-group">
                    <input type="text" name="transaction_number" value="" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-info"></i></span>
              </div> 
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6 col-md-3">
                <label>Amount THB</label>
                <div class="input-group">
                    <input type="text" name="thb" value="{$payment->thb}" class="form-control">
                    <span class="input-group-addon">THB</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Amount USD</label>
                <div class="input-group">
                    <input type="text" name="usd" value="{$payment->usd}" class="form-control">
                    <span class="input-group-addon">USD</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Amount EURO</label>
                <div class="input-group">
                    <input type="text" name="euro" value="{$payment->euro}" class="form-control">
                    <span class="input-group-addon">EURO</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Amount RUB</label>
                <div class="input-group">
                    <input type="text" name="ruble" value="{$payment->ruble}" class="form-control">
                    <span class="input-group-addon">RUB</span>
                </div> 
            </div>
          </div>  
          <div class="row">
            <div class="col-md-12">
                <label>Description</label>
                <div class="input-group">
                    <input type="text" name="description" value="{$payment->description}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-info"></i></span>
                </div> 
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-12">
              <label>Status</label>
              {if Yii::$app->user->can('admin')}
                {html_options name="status" options=$payment->getListStatuses() selected=$payment->status class="form-control"}
              {else}
                <span>{$payment->getStatusName()}</span>
              {/if}
            </div>
          </div>
          
        {include file='layouts/panel.tpl' id=$payment->id}
    </div>
</form>

<script>
  var cars = [
    {foreach $cars as $num=>$car}
      {literal}{{/literal} value: '{$car->number} ({$car->mark} {$car->model}, {$car->color})', data: '{$car->id}', mileage: '{$car->mileage}' {literal}}{/literal},
    {/foreach}
   ];

  {literal}
    $('#car_number').autocomplete({
        source: cars,
        select: function (event, ui) {
                   $('#car_id').val(ui.item.data)
                 }
      });
  {/literal}
</script>