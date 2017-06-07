{include file="layouts/header.tpl"}
            <!-- page content -->
                <div class="col-md-12">
                    <h3>Contracts {$all_records}</h3>
                    <form action="/contracts">
                        <div class="row">
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
                            <div class="col-xs-6 col-md-2">
                                <label>Car:</label>
                                <div class="input-group">
                                    <input type="text" name="car_number" value="" class="form-control" />
                                    <span class="input-group-addon">#</span>
                                </div> 
                            </div>
                            <div class="col-xs-6 col-md-2">
                                <label>Order:</label>
                                <select name="order_by" class="form-control">
                                  {foreach $list_orders as $val=>$arr}
                                    <option value="{$val}" {if isset($params.order_by) && $params.order_by==$val}selected="selected"{/if}>{$arr.name}</option>
                                  {/foreach}
                                </select>
                            </div>
                            <div class="col-md-offset-3 col-xs-6 col-md-1">
                                <label>.</label>
                                <button name="action" value="search" class="btn btn-info btn-block"><span class="glyphicon-search glyphicon"></span></span> Search</button>
                            </div>
                        </div>    
                    </form>
                    <hr>
                {if $message}
                  <div class="alert alert-success">{$message}</div>
                {/if}
                <div class="table-responsive table-full-width">
                    <table class="table table-hover">
                        <thead>
                            <th>#</th>
                            <th>Number</th>
                            <th>Manager</th>
                            <th>Dates</th>
                            <th>Time</th>
                            <th>Customer</th>
                            <th>Phone</th>
                            <th>Phone</th>
                            <th>Location</th>
                            <th>Car</th>
                            <th>Status</th>
                            <th>&nbsp;</th>
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
                            <td>{$contract->number}</td>
                            <td>{$users[$contract->user_id].name}</td>
                            <td>{$contract->date_start|date_format:"d/m/y"} - {$contract->date_stop|date_format:"d/m/y"}</td>
                            <td>{$contract->time}</td>
                            {$customer = $customers[$contract->client_id]}
                            <td><a href="/customers/{$contract->client_id}">{$customer->s_name}</a></td>
                            <td>{$customer->phone_h}</td>
                            <td>{$customer->phone_m}</td>
                            <td>{$contract->location}</td>
                            <td><a href="/cars/view/{$contract->car_id}">{$cars[$contract->car_id]}</a></td>
                            <td>{$contract->getStatusName()}</td>
                            <td><a href="{url route="/contracts/view" id=$contract->id}"><button class="btn btn-info btn-fill btn-xs">View</button></a></td>
                            <td><a href="{url route="/payments" contract_id=$contract->id}"><button class="btn btn-info btn-fill btn-xs">Payments</button></a></td>

                            {if $contract->status == 1}
                              <td><a href="{url route="extend" id=$contract->id}"><button class="btn btn-info btn-fill btn-xs">Extend</button></a></td>
                              <td><a href="{url route="close" id=$contract->id}"><button class="btn btn-info btn-fill btn-xs">Close</button></a></td>
                            {else}
                            <td></td>
                            <td></td>
                            {/if}
                          </tr>
                        </tbody>
                        {/foreach}
                        </tbody>
                    </table>
                    {include file="layouts/paginator.tpl" paginator=$paginator}