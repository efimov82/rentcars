{include file="layouts/header.tpl"}

<!-- page content -->
  <div class="col-md-8">
    <h3>Contracts</h3>
  </div> 
  
  <div class="col-md-4">
    <div id="custom-search-input">
      <form action="/contracts">
        <div class="input-group col-md-12">
          <input type="text" name="car_number" value="{$car_number}" class="search-query form-control" placeholder="Search by car number" />
          <span class="input-group-btn"><button class="btn btn-fill" type="submit"><span class="fa fa-search"></span></button></span>
        </div>
      </form> 
    </div>
  </div>

</div>
{if $message}
  <div class="alert alert-success">{$message}</div>
{/if}


<div class="content table-responsive table-full-width">
  <table class="table table-hover">
    <thead>
      <th>#</th>
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
        <td>{$contract->date_start|date_format:"d/m"} - {$contract->date_stop|date_format:"d/m"}</td>
        <td>{$contract->time}</td>
        {$customer = $customers[$contract->client_id]}
        <td><a href="/clients/$contract->client_id">{$customer->s_name}</a></td>
        <td>{$customer->phone_h}</td>
        <td>{$customer->phone_m}</td>
        <td>{$contract->location}</td>
        <td><a href="/cars/view/{$contract->car_id}">{$cars[$contract->car_id]}</a></td>
        
        <td>{$contract->getStatusName()}</td>
        <td><a href="{url route="/payments" contract_id=$contract->id}"><button class="btn btn-fill btn-xs">Payments</button></a></td>
        <td><a href="{url route="/extend" contract_id=$contract->id}"><button class="btn btn-fill btn-xs">Extend</button></a></td>
        <td><a href="{url route="/close" id=$contract->id}"><button class="btn btn-fill btn-xs">Close</button></a></td>
      </tr>
    </tbody>
    {/foreach}
    </tbody>
</table>