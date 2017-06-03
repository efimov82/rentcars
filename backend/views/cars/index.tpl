<!-- header --!>
{include file="layouts/header.tpl"}
            <!-- page content --!>
            <div class="col-md-6">
                <h3>List of Cars {$all_records}</h3>
            </div>   
            <div class="col-md-6">
                <div id="custom-search-input">
                    <form action="/cars" method="GET">
                        <div class="col-xs-6 col-md-4">
                            <label>Owner:</label>
                            <select name="owner_id" class="form-control">
                                <option value=0>All owners</option>
                                {html_options options=$arr_owners selected=$params.owner_id}
                            </select>
                        </div>
                        <div class="col-xs-6 col-md-4">
                            <label>Status:</label>
                            <select name="status" class="form-control">
                                <option value=0>All statuses</option>
                                {html_options options=$statuses selected=$params.status emptyoption="All"}
                            </select>
                        </div>
                        <div class="col-xs-6 col-md-4">
                            <label>Car number:</label>
                            <div class="input-group col-md-12">
                                <input type="text" name="number" value="{if $params.number > 0}{$params.number}{/if}" class="search-query form-control"/>
                                <span class="input-group-btn"><button class="btn btn-info" type="submit"><span class="fa fa-search"></span></button></span>
                            </div>
                        </div>
                  </form> 
                </div>
            </div>
        </div>
        {if $message}
        <div class="alert alert-success">{$message}</div>
        {/if}
            <div class="table-responsive table-full-width">
                <table class="table table-hover">
                    <thead>
                        <th>ID</th>
                        <th>Number</th>
                        <th>Label</th>
                        <th>Owner</th>
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
                            <td>{$car->mark} {$car->model} ({$car->color|default:"-"}) {if $car->year}{$car->year}{/if}</td>
                            <td>{if isset($owners[$car->owner_id])}{$owners[$car->owner_id].name}{/if}</td>
                            <td>{$car->mileage}</td>
                            
                            {$payment = $car->getLastRentPayment()}
                            {if $payment}
                            <td>{$payment->date|date_format:"%d/%m/%y"} - {$payment->date_stop|date_format:"%d/%m/%y"}</td>
                            <td>{$payment->thb|abs}</td>
                            {else}
                            <td> - </td>
                            <td> - </td>
                            {/if}
                            <td>{$car->getStatusName()}</td>
                            <td>
                                {if Yii::$app->user->can('admin')}
                                  <a href="{url route="cars/pay-rent" id=$car->id}"><button class="btn btn-info btn-xs"><i class="fa fa-pencil-square-o"></i>Pay rent</button></a>
                                  <a href="{url route="cars/edit" id=$car->id}"><button class="btn btn-info btn-xs"><i class="fa fa-pencil-square-o"></i>Edit</button></a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
              {include file="layouts/paginator.tpl" paginator=$paginator}
            </div>
