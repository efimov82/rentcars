{include file="layouts/header.tpl"}

<!-- page content -->
  <div class="col-md-8">
    <h3>Contracts</h3>
  </div> 
  
   
    </div>
  </div>
</div>

<form action="/contracts">
  <div class="row">

    <div class="col-md-4">
      <div class="input-group col-md-12">
        Car number <input type="text" name="car_number" value="{if isset($params.car_number)}{$params.car_number}{/if}" class="search-query form-control" placeholder="Search by car number" />
      </div>
      <div class="input-group col-md-12">
        Contract number<input type="text" name="number" value="{if isset($params.number)}{$params.number}{/if}" class="search-query form-control" placeholder="Search by contract number" />
      </div>
        <div>
            <label>Date start {html_options name="d1_equal" options=$list_equals selected=$params.d1_equal}</label>
            <div class="input-group">
                <input name="date_start" class="datepicker form-control" data-date-format="yyyy-mm-dd" value="{if isset($params.date_start)}{$params.date_start}{/if}" type="text"/>
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div> 
        </div>
        <div>
            <label>Date finish {html_options name="d2_equal" options=$list_equals selected=$params.d2_equal}</label>
            <div class="input-group">
              
                <input name="date_stop" class="datepicker form-control" data-date-format="yyyy-mm-dd" value="{if isset($params.date_stop)}{$params.date_stop}{/if}" type="text"/>
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div> 
        </div>
        <input type="submit" value="Search" />
    </div> 
  </div> 

</form> 
{if $message}
  <div class="alert alert-success">{$message}</div>
{/if}

<div>Find records: {$all_records}</>

<div class="content table-responsive table-full-width">
  <table class="table table-hover">
    <thead>
      <th>#</th>
      <th>Number</th>
      <th>Manager</th>
      <th>Dates</th>
      <th>Time</th>
      <th>Client</th>
      <th>Phone Rus</th>
      <th>Phone Thai</th>
      <th>Location</th>
      <th>Car</th>
      <th>Status</th>
      <th>&nbsp;</th>
    </thead>
    <tbody>
    {foreach $contracts->each() as $contract}
    <tbody>
      <tr {if $contract->isFinishSoon()}class="danger"{else} 
            {if ($contract->status == 1)}class="success"{else}class="warning"{/if} {/if}>
        <td>{$contract->id}</td>
        <td>{$contract->number}</td>
        <td>{$users[$contract->user_id].name}</td>
        <td>{$contract->date_start|date_format:"d/m/y"} - {$contract->date_stop|date_format:"d/m/y"}</td>
        <td>{$contract->time}</td>
        {$customer = $customers[$contract->client_id]}
        <td><a href="/clients/$contract->client_id">{$customer->s_name}</a></td>
        <td>{$customer->phone_h}</td>
        <td>{$customer->phone_m}</td>
        <td>{$contract->location}</td>
        <td><a href="/cars/view/{$contract->car_id}">{$cars[$contract->car_id]}</a></td>
        
        <td>{$contract->getStatusName()}</td>
        <td><a href="{url route="/contracts/view" id=$contract->id}"><button class="btn btn-fill btn-xs">View</button></a></td>
        <td><a href="{url route="/payments" contract_id=$contract->id}"><button class="btn btn-fill btn-xs">Payments</button></a></td>
        {if $contract->status == 1}
        <td><a href="{url route="extend" id=$contract->id}"><button class="btn btn-fill btn-xs">Extend</button></a></td>
        <td><a href="{url route="close" id=$contract->id}"><button class="btn btn-fill btn-xs">Close</button></a></td>
        {else}
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        {/if}
      </tr>
    </tbody>
    {/foreach}
    </tbody>

</table>

{include file="layouts/paginator.tpl" paginator=$paginator}