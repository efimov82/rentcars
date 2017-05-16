{include file="layouts/header.tpl"}

<!-- page content -->
  <div class="col-md-8">
    <h3>Contracts</h3> <a href="/contracts/add">Add contract</a>
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
      <th>Client</th>
      <th>Car</th>
      <th>Status</th>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
      <th>&nbsp;</th>
    </thead>
    <tbody>
    {foreach $contracts->each() as $contract}
    <tbody>
      <tr {if $contract->isFinishSoon()}class="danger"{else} 
            {if ($contract->status == 1)}class="success"{else}class="warning"{/if} {/if}>
        <td>{$contract->id}</td>
        <td>{$contract->date_start|date_format:"d/m/y"} - {$contract->date_stop|date_format:"d/m/y"}</td>
        <td><a href="/clients/$contract->client_id">{$customers[$contract->client_id]}</a></td>
        <td><a href="/cars/view/{$contract->car_id}">#{$cars[$contract->car_id]}</a></td>
        <td>{$contract->getStatusName()}</td>
        {*<td><a href="{url route="contracts/edit" id=$contract->id}"><button class="btn btn-fill btn-xs"><i class="fa fa-pencil-square-o"></i>Edit</button></a></td>*}
        <td><a href="{url route="/payments" contract_id=$contract->id}">PAYMENTS</a></td>
        <td><a href="{url route="/contracts/extend" id=$contract->id}">Extend</a></td>
        <td><a href="{url route="/contracts/close" id=$contract->id}">Close</a></td>
      </tr>
    </tbody>
    {/foreach}
    </tbody>
</table>