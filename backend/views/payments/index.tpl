<!-- header -->
{include file="layouts/header.tpl"}

<!-- page content -->
  <div class="col-md-8">
    <h3>Payments</h3>
  </div>          

  <div class="col-md-4">
    <div id="custom-search-input">
      <form action="/payments">
        <div class="input-group col-md-12">
          <input type="text" name="car_number" value="{if $car_number}{$car_number}{/if}" class="search-query form-control" placeholder="Search by car number" />
          <span class="input-group-btn"><button class="btn btn-fill" type="submit"><span class="fa fa-search"></span></button></span>
        </div>
      </form> 
    </div>
  </div>
</div>

<div>Find records: {$all_records}</>
<div class="content table-responsive table-full-width">
  <table class="table table-hover">
    <thead>
      <th>#</th>
      <th>Date</th>
      <th>User</th>
      <th>Category</th>
      <th>Type</th>
      <th>Contract</th>
      <th>Car #</th>
      <th>USD</th>
      <th>EUR</th>
      <th>THB</th>
      <th>RUB</th>
      <th>Status</th>
      <th>&nbsp;</th>
    </thead>
    <tbody>
    {foreach $payments->each() as $payment}
      <tr {if ($payment->status == 1)}class="warning"{elseif $payment->status == 4}class="danger"{else}class="success"{/if}>
      <td>{$payment->id}</td>
      <td>{$payment->date|date_format:'%d/%m/%y'}</td>
      <td>{$users[$payment->user_id]->name}</td>
      <td>{$categories[$payment->category_id]->name}</td>
      <td>{if ($payment->type_id == 1)}+{else}-{/if}</td>
      <td><a href="{url route="/contracts/view/" id=$payment->contract_id}">{$payment->contract_id}</a></td>
      <td>{$cars[$payment->car_id]->number}</td>
      <td>{$payment->usd}</td>
      <td>{$payment->euro}</td>
      <td>{$payment->thb}</td>
      <td>{$payment->ruble}</td>
      <td>{$payment->getStatusName()}</td>
      <td>{if Yii::$app->user->can('admin')}<a href="{url route="payments/edit" id=$payment->id}"><button class="btn btn-fill btn-xs"><i class="fa fa-pencil-square-o"></i>Edit</button></a>{/if}</td>
      </tr>
    {/foreach}
    </tbody>
  </table>

{include file="layouts/paginator.tpl" paginator=$paginator}
</div>

