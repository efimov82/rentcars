<!-- header --!>
{include file="layouts/header.tpl"}

<!-- page content --!>
  <div class="col-md-8">
      <h3>List of cars</h3>
  </div>   

  <div class="col-md-4">
      <div id="custom-search-input">
          <form action="/cars">
              <div class="input-group col-md-12">
                  <input type="text" name="number" value={$number} class="search-query form-control" placeholder="Search by number" />
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
                    <th>ID</th>
                    <th>Car Number</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Color</th>
                    <th>Mileage</th>
                    <th>Dates of Lease</th>
                    <th>Price (Thb)</th>
                    <th>Status</th>
                    <th></th>
                    </tr>
                </thead>
                <tbody>
                {foreach $cars->each() as $car}
                    <tr {if ($car->status == 1)}class="success"{else}class="warning"{/if}>
                    <td>{$car->id}</td>
                    <td>{$car->number}</td>
                    <td>{$car->mark}</td>
                    <td>{$car->model}</td>
                    <td>{$car->color}</td>
                    <td>{$car->mileage}</td>
                    
                    {$payment = $car->getLastRentPayment()}
                    {if $payment}
                    <td>{$payment->date|date_format:"%d/%m"} - {$payment->date_stop|date_format:"%d/%m"}</td>
                    <td>{$payment->thb}</td>
                    {else}
                    <td> - </td>
                    <td> - </td>
                    {/if}
                    <td>{$car->getStatusName()}</td>
                    <td>
                        <a href="{url route="cars/payments" id=$car->id}"><button class="btn btn-fill btn-xs"><i class="fa fa-pencil-square-o"></i>Payments</button></a>
                        {if Yii::$app->user->can('admin')}
                          <a href="{url route="cars/pay-rent" id=$car->id}"><button class="btn btn-fill btn-xs"><i class="fa fa-pencil-square-o"></i>Pay rent</button></a>
                          <a href="{url route="cars/edit" id=$car->id}"><button class="btn btn-fill btn-xs"><i class="fa fa-pencil-square-o"></i>Edit</button></a>
                        {/if}
                    </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>