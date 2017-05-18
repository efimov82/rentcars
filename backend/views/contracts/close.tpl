{* my old
{include file="layouts/header.tpl"}
<!-- page content -->
  <form action="" method="POST">
    <div class="col-md-6">
    <h3>Close Contract #{$contract->id}</h3>
        
        <div class="row">
          <div class="col-xs-6 col-md-6">
              <label>Info</label>
              <div class="input-group">
              <div>Date start: {$contract->date_start|date_format:"%d-%m-%Y"}</div>
              <div>Date finish: {$contract->date_stop|date_format:"%d-%m-%Y"}</div>
              {$car = $cars[$contract->car_id]}
              <div>Car: #{$car.number} ({$car->mark} {$car->model})</div>
              <div>Customer: {$contract->client_id}</div>
              </div>
          </div>
          <div class="col-xs-6 col-md-6">
              <label>Payments</label> (тут наверное лучше таблицу - ну и чтобы она была как сейчас справа - место экономит)
              <div class="input-group">
                <div><strong>ID, Date, Category, Type, USD, EURO, THB. RUB</strong></div>
                {foreach $payments as $num=>$payment}
                  <div>#{$payment->id} {$payment->date|date_format:"%d-%m-%Y"}, {$payment->category_id}, {$payment->type_id}, {$payment->usd}, {$payment->euro}, {$payment->thb}, {$payment->ruble}</div>
                {/foreach}
              </div>  
          </div>
            <div class="col-xs-6 col-md-6">
                <label>Additional payments</label>
                {$currency_list = ['usd'=>'usd', 'euro'=>'euro', 'thb'=>'thb', 'rub'=>'rub']}
                <div class="input-group">
                    Clean car: <input type="text" name="clean" value="0" class="form-control">
                    {html_options name="clean_cur" options=$currency_list class="form-control"}
*}

            {include file="layouts/header.tpl"} {$car = $cars[$contract->car_id]}
            <!-- page content -->
            <form action="" method="POST">
                <div class="col-md-6">
                    <h3>Close Contract #{$contract->id}</h3>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Car Number</label>
                            <div class="input-group">
                                <input type="text" id="mileage" name="car_mileage" value="{$car.number}" class="form-control" disabled=1>
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Car Info</label>
                            <div class="input-group">
                                <input type="text" id="mileage" name="car_mileage" value="{$car->mark} {$car->model} {$car->color}" class="form-control" disabled=1>
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div> 
                        </div>
                    </div>    
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Client Name</label>
                            <div class="input-group">
                                <input type="text" id="mileage" name="car_mileage" value="{$contract->client_id}" class="form-control" disabled=1>
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Type Client</label>
                            <select class="form-control system-add-price" name="Sex">
                                <option data="male" value="Male">Pauper</option>
                                <option data="male" value="Male">Middle</option>
                                <option data="female" value="Woman">Rich</option>
                            </select>
                        </div>
                    </div>    
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Data of Start</label>
                            <div class="input-group">
                                <input name="date_start" class="datepicker form-control" value="{$contract->date_start|date_format:"%d-%m-%Y"}" type="text"/ disabled=1>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Data of Finish</label>
                            <div class="input-group">
                                <input name="date_start" class="datepicker form-control" value="{$contract->date_stop|date_format:"%d-%m-%Y"}" type="text"/ disabled=1>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Washing Car</label>
                            <div class="input-group">
                                <input type="text" name="clean" value="" class="form-control">
                                <span class="input-group-addon">THB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Repair Car</label>
                            <div class="input-group">
                                <input type="text" name="repair" value="" class="form-control">
                                <span class="input-group-addon">THB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Gasoline</label>
                            <div class="input-group">
                                <input type="text" name="gasoline" value="" class="form-control">
                                <span class="input-group-addon">THB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Overtime</label>
                            <div class="input-group">
                                <input type="text" name="amount_ruble" value="" class="form-control">
                                <span class="input-group-addon">THB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Deposit THB</label>
                            <div class="input-group">
                                <input type="text" name="amount_thb" value="" class="form-control">
                                <span class="input-group-addon">THB</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Deposit USD</label>
                            <div class="input-group">
                                <input type="text" name="amount_usd" value="" class="form-control">
                                <span class="input-group-addon">USD</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Deposit EURO</label>
                            <div class="input-group">
                                <input type="text" name="amount_euro" value="" class="form-control">
                                <span class="input-group-addon">EURO</span>
                            </div> 
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>Deposit RUB</label>
                            <div class="input-group">
                                <input type="text" name="amount_ruble" value="" class="form-control">
                                <span class="input-group-addon">RUB</span>
                            </div> 
                        </div>
                        <div class="col-md-12">
                            <label>Description</label>
                            <div class="input-group">
                                <input type="text" name="amount_ruble" value="" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-info"></i></span>
                            </div> 
                        </div>
                    </div> 
                </div>    
                <div class="col-md-6">
                    <h3>History Payments</h3>
                    <div class="content table-responsive table-full-width">
                        <table class="table table-hover">
                            <thead>
                                <th>ID</th>
                                <th>Date</th>
                                <th>Category</th>
                                <th>Type</th>
                                <th>THB</th>
                                <th>USD</th>
                                <th>EURO</th>
                                <th>RUB</th>
                            </thead>
                            <tbody>
                            {foreach $payments as $num=>$payment}
                            <tbody>
                              <tr>
                                <td>{$payment->id}</td>
                                <td>{$payment->date|date_format:"%d-%m-%Y"}</td>
                                <td>{$payment->category_id}</td>
                                <td>{$payment->type_id}</td>
                                <td>{$payment->usd}</td>
                                <td>{$payment->euro}</td>
                                <td>{$payment->thb}</td>
                                <td>{$payment->ruble}</td>
                              </tr>
                            </tbody>{/foreach}</tbody>
                        </table>
                    </div>
                    <div class="tim-title">
                        <div class="row">
                            <div class="col-md-4">
                                <button name="action" value="save" class="btn btn-block"><i class="fa fa-floppy-o"></i> Close</button>
                            </div>
                        </div>
                    </div>
                </div>
  </form>
