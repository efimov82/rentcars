{include file="layouts/header.tpl"}
            <!-- page content -->
                <div class="col-md-12">
                    <h3>Contracts</h3>
                </div>
                <form action="/contracts">
                <div class="row">
                    <div class='col-xs-6 col-md-2'>
                        <div class="form-group">
                            <div class='input-group date' id='datetimepicker6'>
                                <input type='text' class="form-control" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class='col-xs-6 col-md-2'>
                        <div class="form-group">
                            <div class='input-group date' id='datetimepicker7'>
                                <input type='text' class="form-control" />
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6 col-md-2">
                        <label>Date from:</label>
                        <div class="input-group input-group-lg">
                            <input name="date_start" class="datepicker form-control" data-date-format="dd/mm/yyyy" value="" type="text"/>
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

                </div>
                <div class="row">
                    <div class="col-md-offset-10 col-md-2">
                        <div class="tim-title">
                            <a name="action" value="search" class="btn btn-info btn-lg btn-block"><i class="fa fa-search"></i>Search</a>
                        </div>
                    </div>
                </div>    
            </form>
                {if $message}
                  <div class="alert alert-success">{$message}</div>
                {/if}
                
                <div>Find records: {$all_records}</>
                
                <div class="table-responsive table-full-width">
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