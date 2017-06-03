<!-- header -->
{include file="layouts/header.tpl"}
            <!-- page content -->
            <div class="col-md-12">
                <h3>Payments {$all_records}</h3>
                <form action="" method="POST">
                    <div class="row">
                        <div class="col-xs-6 col-md-2">
                            <label>Date from:</label>
                            <div class="input-group input-group-lg" id="date_start">
                                <input class="datepicker form-control" data-date-format="dd/mm/yyyy" value="" type="text"/>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-2">
                            <label>Date to:</label>
                            <div class="input-group input-group-lg">
                                <input name="date_stop" class="datepicker form-control" data-date-format="dd/mm/yyyy" value="" type="text"/>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-2">
                            <label>Car number:</label>
                            <div class="input-group input-group-lg">
                                <input type="text" name="car_number" value="" class="form-control" />
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div> 
                        </div> 
                        <div class="col-xs-6 col-md-1">
                            <label>User:</label>
                            <select name="user_id" class="form-control input-lg">
    
                            </select>
                        </div>              
                        <div class="col-xs-6 col-md-1">
                            <label>Type:</label> 
                            <select name="payment_type" class="form-control input-lg">
                                <option value="0" class="form-control option">ALL</option>
                                <option value="1" class="form-control option">INCOME</option>
                                <option value="2" class="form-control option">OUTGOING</option>
                            </select>
                        </div>
                        <div class="col-xs-6 col-md-1">
                            <label>Status:</label>
                            
                        </div>
                        <div class="col-xs-6 col-md-1">
                            <label>Category:</label> 
                            <select name="payment_category" class="form-control input-lg">
                                
                            </select>
                        </div>
                        <div class="col-xs-6 col-md-2">
                            <label>Group by:</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-offset-10 col-md-2">
                            <div class="tim-title">
                                <a name="action" value="search" class="btn btn-info btn-lg btn-block"><i class="fa fa-search"></i> Search</a>
                            </div>
                        </div>
                    </div>    
                </form>
            </div> 

              <div class="col-md-4">
                  <form action="/payments">
                      <input type="text" name="car_number" value="{if $car_number}{$car_number}{/if}" />
                  </form> 
              </div>
            </div>
            <div class="row">
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
                </div>
                {include file="layouts/paginator.tpl" paginator=$paginator}
            </div>

