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
                {foreach $payments->each() as $payment}
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
                </div>
                <div class="input-group">
                    Repair car: <input type="text" name="repair" value="0" class="form-control">
                    {html_options name="repair_cur" options=$currency_list class="form-control"}
                </div>
                <div class="input-group">
                    Gasoline: <input type="text" name="gasoline" value="0" class="form-control">
                    {html_options name="gasoline_cur" options=$currency_list class="form-control"}
                </div>
            </div>
            
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
