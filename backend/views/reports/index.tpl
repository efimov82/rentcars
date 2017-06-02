<!-- header --!>
{include file="layouts/header.tpl"}
    <!-- page content --!>
        <div class="col-md-12">
        <!-- search form -->
            <h3>Reports</h3>
            <form action="" method="POST">
                <div class="row">

                <label>Dates:</label>
                <div class="input-group input-group-lg">
                
                  <input id="date_start" name="date_start" value="{if isset($params.date_start)}{$params.date_start|date_format:"d.m.Y"}{/if}" type="text" class="datepicker"/>
                  <input id="date_stop" name="date_stop" value="{if isset($params.date_stop)}{$params.date_stop|date_format:"d.m.Y"}{/if}" type="text" class="datepicker"/>
                </div>
                  
                  


                {*
<input  name="date_start" value="" required="required" type="text" placeholder="Date from">
                  <input id="date_stop" name="date_stop" value="" required="required" type="text" placeholder="Date to">

                  <div class="input-group date" id="datetimepicker_start">
                    
                    <span class="input-group-addon"><span class="glyphicon-calendar glyphicon"></span></span>
                  </div>
                  <div class="input-group date" id="datetimepicker_stop">
                    <input value="" class="form-control" name="date_stop" required="required" type="text" placeholder="Date to">
                    <span class="input-group-addon"><span class="glyphicon-calendar glyphicon"></span></span>
                  </div>
                  *}



                    {* OLD
                      <div class="col-xs-6 col-md-2">
                        <label>Date from:</label>
                        <div class="input-group input-group-lg">
                            <input name="date_start" class="datepicker form-control" data-date-format="dd/mm/yyyy" value="{if isset($params.date_start)}{$params.date_start}{/if}" type="text"/>
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div> 
                    </div>
                    <div class="col-xs-6 col-md-2">
                        <label>Date to:</label>
                        <div class="input-group input-group-lg">
                            <input name="date_stop" class="datepicker form-control" data-date-format="dd/mm/yyyy" value="{if isset($params.date_stop)}{$params.date_stop}{/if}" type="text"/>
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div> 
                    </div>
                    *}
                    <div class="col-xs-6 col-md-2">
                        <label>Car number:</label>
                        <div class="input-group input-group-lg">
                            <input type="text" name="car_number" value="{if isset($params.car_number)}{$params.car_number}{/if}" class="form-control" />
                            <span class="input-group-addon"><i class="fa fa-car"></i></span>
                        </div> 
                    </div> 
                    <div class="col-xs-6 col-md-1">
                        <label>User:</label>
                        <select name="user_id" class="form-control input-lg">
                            <option value="" class="form-control option">ALL</option>
                            {foreach $users as $num=>$user}
                            <option value="{$user.id}"{if $params.user_id == $user.id} selected="selected"{/if}>{$user.username}</option>
                            {/foreach}
                        </select>
                    </div>              
                    <div class="col-xs-6 col-md-1">
                        <label>Type:</label> 
                        <select name="payment_type" class="form-control input-lg">
                            <option value="0" class="form-control option">ALL</option>
                            <option value="1" class="form-control option" {if $params.payment_type == 1}selected=selected{/if}>INCOME</option>
                            <option value="2" class="form-control option" {if $params.payment_type == 2}selected=selected{/if}>OUTGOING</option>
                        </select>
                    </div>
                    <div class="col-xs-6 col-md-1">
                        <label>Status:</label>
                        {html_options name="payment_status" options=$payments_statuses emptyoption="ALL" selected=$params.payment_status class="form-control input-lg"}
                    </div>
                    <div class="col-xs-6 col-md-1">
                        <label>Category:</label> 
                        <select name="payment_category" class="form-control input-lg">
                            <option value="0"  class="form-control option">ALL</option>
                            {foreach $categories as $num=>$arr}
                            <option value="{$arr.id}" class="form-control option"{if $arr.id == $params.payment_category} selected="selected"{/if}>{$arr.name}</option>
                        {/foreach}
                        </select>
                    </div>
                    <div class="col-xs-6 col-md-2">
                        <label>Group by:</label>
                            <select id="group_by" name="group_by[]" {*multiple="multiple" size=2*} class="form-control input-lg">
                            {foreach $group_by_list as $val=>$name}
                            <option value="{$val}" {if isset($params['group_by'][$val])}selected="selected"{/if}>{$name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-offset-10 col-md-2">
                        <div class="tim-title">
                            <a name="action" value="search" class="btn btn-info btn-lg btn-block"><i class="fa fa-search"></i>Search</a>
                        </div>
                    </div>
                </div>    
            </form>
                
        <!-- results -->
        {if $params.hasPost}
            <h3>Search results</h3>
            {if $results}
            <div class="table-responsive table-full-width">
                <table class="table table-hover">
                    <thead>
                        <th>#</th>
                        <th>date</th>
                        {if isset($params.group_by.users)}<th>user</th>{/if}
                        {if isset($params.group_by.cars)}<th>car#</th>{/if}
                        {if isset($params.group_by.types)}<th>type</th>{/if}
                        {if isset($params.group_by.categories)}<th>category</th>{/if}
                        {if isset($params.group_by.statuses)}<th>status</th>{/if}
                        <th>thb</th>
                        <th>usd</th>
                        <th>eur</th>
                        <th>rub</th>
                    </thead>
                    <tbody>
                        {$all_thb=0}
                        {$all_usd=0}
                        {$all_euro=0}
                        {$all_ruble=0}
                        {foreach $results as $num=>$data}
                        <tr  {if ($data.type_id == 1)}class="success"{else}class="danger"{/if}>
                            <td>{$data@iteration}</td>
                            <td>{if isset($params.group_by.days)}{$data.date|date_format:"d/m"}{else}&nbsp;{/if}</td>
                            {if isset($params.group_by.users)}<td>{$users[$data.user_id].username}</td>{/if}
                            {if isset($params.group_by.cars)}<td>{$cars[$data.car_id].number}</td>{/if}
                            {if isset($params.group_by.types)}<td>{if $data.type_id == 1}+{else}-{/if}</td>{/if}
                            {if isset($params.group_by.categories)}<td>{$categories[$data.category_id].name}</td>{/if}
                            {if isset($params.group_by.statuses)}<td>{$payments_statuses[$data.status]}</td>{/if}
                            <td>{$data.sum_thb}</td>
                            <td>{$data.sum_usd}</td>
                            <td>{$data.sum_euro}</td>
                            <td>{$data.sum_ruble}</td>
                            {$all_thb = $all_thb + $data.sum_thb}
                            {$all_usd = $all_usd + $data.sum_usd}
                            {$all_euro = $all_euro + $data.sum_euro}
                            {$all_ruble = $all_ruble + $data.sum_ruble}
                        </tr>
                        {/foreach}
                        
                        <tr class="alert alert-info">
                            <td><strong>TOTAL ({$results|count})</strong></td>
                            <td>&nbsp;</td>
                            {if isset($params.group_by.users)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.cars)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.types)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.categories)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.statuses)}<td>&nbsp;</td>{/if}
                            <td><strong>{$all_thb}</strong></td>
                            <td><strong>{$all_usd}</strong></td>
                            <td><strong>{$all_euro}</strong></td>
                            <td><strong>{$all_ruble}</strong></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            {else}
              <div>Empty result of search</div>
            {/if}
        </div>
        {/if}

{literal}
<script type="text/javascript">
	 
    // Init datePicker
    $('#date_start').datepicker({
		  format: 'dd.mm.yyyy',
      weekStart: 1
		}).on('changeDate', function(ev){
          stop = moment(ev.date).add(1, 'days').format('DD.MM.YYYY');
          $('#date_stop').val(stop);
          }
      );

		$('#date_stop').datepicker({
		  format: 'dd.mm.yyyy',
      weekStart: 1
		}).on('changeDate', function(ev){
          start = moment(ev.date).subtract(1, 'days').format('DD.MM.YYYY');
          $('#date_start').val(start);
          }
      );
</script>
{/literal}
