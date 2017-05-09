{include file="layouts/header.tpl"}
            <!-- page content1 --!>
            <h3>Add/Edit payment for car <b>#{$car->number} {$car->mark} {$car->model}</b></h3>
            <div class="row">
                <form action="/cars/save-payment" method="POST">
                <input type="hidden" name="car_id" value="{$car->id}" />
                <div class="col-xs-6 col-md-3">
                  <label>Date</label>
                  <div class="input-group">
                    <input type="text" name="date" value="{$payment->date}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-car"></i></span>
                  </div>  
                </div>
                <div class="col-xs-6 col-md-3">
                  <label>Sum</label>
                  <div class="input-group">
                    <input type="text" name="sum" value="{$payment->sum}" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-car"></i></span>
                  </div>  
                </div>
                <div class="col-xs-6 col-md-3">
                  <label>Description</label>
                  <div class="input-group">
                    <input type="text" name="description" value="{$payment->description}" class="form-control">
                  </div>  
                </div>
            </div>

  <!-- panel save --!>
  <div class="row">
    <div class="tim-title">
      <div class="col-md-2">
        <button name="action" value="save" class="btn btn-block">Save</button>
      </div>
    </div>
    {if $payment->id}
    <div class="tim-title">
      <div class="col-md-2">
        <button name="action" value="delete" class="btn btn-block">Delete</button></a>
      </div>
    </div>
    {/if}
    <div class="tim-title">
      <div class="col-md-2">
        <button name="action" value="cancel" class="btn btn-block">Cancel</button>
      </div>
    </div>
  </div>
  <!-- end panel --!>
</form>