{include file="layouts/header.tpl"}
<!-- page content -->
<form action="/contracts/save" enctype="multipart/form-data" method="POST">
    <div class="col-md-6">
    <h3>Add/Edit contract</h3>
        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Car Number</label>
                <div class="input-group ui-widget">
                  <input type="text" id="car_number" name="car_number" value=""  class="form-control">
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
                    <input class="datepicker form-control" type="text"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div> 
            <div class="col-xs-6 col-md-6">
                <label>Data of Finish</label>
                <div class="input-group">
                    <input class="datepicker form-control" type="text"/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Time</label>
                <div class="input-group">
                    <input type="text" class="form-control">
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
                <label>Mobile Phome</label>
                <div class="input-group">
                    <input type="text" value="+7" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Home Phone</label>
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
                <label>Type Client</label>
                <select class="form-control system-add-price" name="Sex">
                    <option data="male" value="Male">Pauper</option>
                    <option data="male" value="Male">Middle</option>
                    <option data="female" value="Woman">Rich</option>
                </select>
            </div>
        </div>
        <label>Add Files</label>
        <div class="input-group">
            <label class="input-group-btn"><span class="btn btn-fill">Browse<input type="file" style="display: none;" multiple></span></label>
            <input type="text" name="image1" class="form-control" readonly>
        </div>
        <div class="input-group">
            <label class="input-group-btn"><span class="btn btn-fill">Browse<input type="file" style="display: none;" multiple></span></label>
            <input type="text" name="image2" class="form-control" readonly>
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