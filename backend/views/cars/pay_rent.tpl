{include file="layouts/header.tpl"}
  <!-- page content --!>
  <form action="" method="POST">
      <input name="id" value="{$car->id}" type="hidden"/>
      <div class="col-md-6">
        <h3>Edit payment car rental</h3>
      
        <div class="row">
          <div class="col-xs-8 col-md-8">
              <label># Car</label>
              <div class="input-group">
                  <input name="number" value="{$car->number}" class="form-control" type="text" disabled=1/>
                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
              </div>
              <label>Date start of Lease</label>
              <div class="input-group">
                  <input name="start_lease" value="{time()|date_format:"%Y-%m-%d"}" class="datepicker form-control" type="text"/>
                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
              </div>
              <label>Date finish of Lease</label>
              <div class="input-group">
                  <input name="stop_lease" value="{(time()+24*3600*30)|date_format:"%Y-%m-%d"}" class="datepicker form-control" type="text"/>
                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
              </div>
              <label>Sum of payment (THB)</label>
              <div class="input-group">
                  <input name="price" value="" class="form-control" type="text"/>
                  <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
              </div>
              {include file='layouts/panel.tpl' id=0}
          </div>
          
        </div>
      </div>
  </form>