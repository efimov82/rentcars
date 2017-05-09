{include file="layouts/header.tpl"}
<!-- page content --!>
<form action="/payments/save" method="POST">
    <div class="col-md-6">
        <h3>Add/Edit payment</h3>
        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Car Number</label>
                <div class="input-group">
                    <input type="text" name="car_number" value="{$payment->getCar()->number}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-car"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Contract Number</label>
                <div class="input-group">
                    <input type="text" name="contract_id" value="" class="form-control">
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
            <div class="col-xs-6 col-md-6">
                <label>Amount in Thai Baht</label>
                <div class="input-group">
                    <input type="text" name="thb" value="{$payment->thb}" class="form-control">
                    <span class="input-group-addon">THB</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Amount in US Dollar</label>
                <div class="input-group">
                    <input type="text" name="usd" value="{$payment->usd}" class="form-control">
                    <span class="input-group-addon">USD</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Amount in Euro</label>
                <div class="input-group">
                    <input type="text" name="euro" value="{$payment->euro}" class="form-control">
                    <span class="input-group-addon">EURO</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Amount in Rubles</label>
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
                    <input type="text" name="description" value="" class="form-control">
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