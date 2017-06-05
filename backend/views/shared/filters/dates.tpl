{****** 
Usage: {include file="shared/filters/dates.tpl" params=$params}
*******}
<!-- dates.tpl -->
<div class="col-xs-6 col-md-2">
  <label>Date from:</label>
  <div class="input-group">
      <input id="date_start" name="date_start" value="{if isset($params.date_start)}{$params.date_start|date_format:"d.m.Y"}{/if}" type="text" class="form-control datepicker"/>
      <span class="input-group-addon"><span class="glyphicon-calendar glyphicon"></span></span>
  </div> 
</div>
<div class="col-xs-6 col-md-2">
  <label>Date to:</label>
  <div class="input-group">
      <input id="date_stop" name="date_stop" value="{if isset($params.date_stop)}{$params.date_stop|date_format:"d.m.Y"}{/if}" type="text" class="form-control datepicker"/>
      <span class="input-group-addon"><span class="glyphicon-calendar glyphicon"></span></span>
  </div> 
</div>
<!-- end dates.tpl -->