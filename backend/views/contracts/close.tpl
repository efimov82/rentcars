{include file="layouts/header.tpl"}
<!-- page content -->
<form action="" method="POST">
    <div class="col-md-6">
    <h3>Close Contract #{$contract->id}</h3>
        
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
