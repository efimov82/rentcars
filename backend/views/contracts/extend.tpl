{include file="layouts/header.tpl"}
<!-- page content -->
<form action="" method="POST">
  <input type="hidden" name="id" value="{$contract->id}">
    <div class="col-md-6">
    <h3>Extend contract #{$contract->id}</h3>
        
        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Current Date of Finish</label>
                <div class="input-group">
                    <input name="date_stop" class="datepicker form-control" value="{$contract->date_stop}" type="text" disabled=1/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Current Time</label>
                <div class="input-group">
                    <input type="text" name="time" value="{$contract->time}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                </div>  
            </div>

            <div class="col-xs-6 col-md-6">
                <label>New Date of Finish</label>
                <div class="input-group">
                    <input name="date_stop" class="datepicker form-control" value="{$contract->date_stop}" type="text"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>New Time</label>
                <div class="input-group">
                    <input type="text" name="time" value="{$contract->time}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                </div>  
            </div>
            
            <div class="col-xs-6 col-md-3">
                <label>Surcharge THB</label>
                <div class="input-group">
                    <input type="text" name="amount_thb" value="" class="form-control">
                    <span class="input-group-addon">THB</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Surcharge USD</label>
                <div class="input-group">
                    <input type="text" name="amount_usd" value="" class="form-control">
                    <span class="input-group-addon">USD</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Surcharge EURO</label>
                <div class="input-group">
                    <input type="text" name="amount_euro" value="" class="form-control">
                    <span class="input-group-addon">EURO</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-3">
                <label>Surcharge RUB</label>
                <div class="input-group">
                    <input type="text" name="amount_ruble" value="" class="form-control">
                    <span class="input-group-addon">RUB</span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Status payment</label>
                {html_options name="status" options=$payments_statuses class="form-control"}
            </div>

        </div>    
        {include file='layouts/panel.tpl' id=0}
    </div>
</form>