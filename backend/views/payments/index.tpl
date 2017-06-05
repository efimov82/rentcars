<!-- header -->
{include file="layouts/header.tpl"}
            <!-- page content -->
            <div class="col-md-12">
                <h3>Payments {if $params.all_records}(find {$params.all_records} records){/if}</h3>
                <form action="/payments" method="GET">
                    <div class="row">
                        {include file="shared/filters/dates.tpl" params=$params}
                        <div class="col-xs-6 col-md-2">
                        <label>Car:</label>
                        <div class="input-group">
                            <input type="text" name="car_number" value="{if isset($params.car_number)}{$params.car_number}{/if}" class="form-control" />
                            <span class="input-group-addon">#</span>
                        </div> 
                    </div> 
                    {include file="shared/filters/managers.tpl" managers=$managers params=$params}
                    <div class="col-xs-6 col-md-2">
                        <label>Category:</label> 
                        <select name="payment_category" class="form-control">
                            <option value="0"  class="form-control option">ALL</option>
                            {foreach $categories as $num=>$arr}
                            <option value="{$arr.id}" class="form-control option"{if $arr.id == $params.payment_category} selected="selected"{/if}>{$arr.name}</option>
                        {/foreach}
                        </select>
                    </div>
                    {include file="shared/filters/payment_types.tpl" params=$params}
                    <div class="col-xs-6 col-md-1">
                        <label>Status:</label>
                        {html_options name="payment_status" options=$payments_statuses emptyoption="ALL" selected=$params.payment_status class="form-control"}
                    </div>

                    <div class="row">
                      <div class="col-md-offset-10 col-xs-12 col-md-1">
                          <button name="action" value="search" class="btn btn-info btn-block"><span class="glyphicon-search glyphicon"></span></span> Search</button>
                      </div>
                        
                    </div>    
            </div> 
            </form> 
              </div>
            </div>
            <hr>
            <div class="row">
                {if $payments}
                <h3>Search results</h3>
                <div class="table-responsive table-full-width">
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
                        {foreach $payments as $num=>$payment}
                            <tr {if ($payment->status == 1)}class="warning"{elseif $payment->status == 4}class="danger"{else}class="success"{/if}>
                            <td>{$payment->id}</td>
                            <td>{$payment->date|date_format:'%d/%m/%y'}</td>
                            <td>{if isset($managers[$payment->user_id])}{$managers[$payment->user_id].name}{$payment->user_id}{else}{/if}</td>
                            <td>{$categories[$payment->category_id].name}</td>
                            <td>{if ($payment->type_id == 1)}+{else}-{/if}</td>
                            <td><a href="{url route="/contracts/view/" id=$payment->contract_id}">{$payment->contract_id}</a></td>
                            <td>{if isset($cars[$payment->car_id])}{$cars[$payment->car_id]->number}{/if}</td>
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
                </div>
                {include file="layouts/paginator.tpl" paginator=$paginator}
                {/if}
            </div>

