{include file="layouts/header.tpl"}
<!-- page content -->
    <div class="col-md-6">
    <h3>Contract #{$contract->id}</h3> <div>( cteated at {$contract->date_create|date_format:"d.m.Y, H:i:s"})</div>
        
    <div id="renter_info">
      <div><b>Renter: </b></div>
      <p>Name: {$customer->f_name} {$customer->s_name} {$customer->l_name}</p>
      <p>Passport: #{$customer->passport}</p>
      <p>Phones:  thai: {$customer->phone_m}, rus: {$customer->phone_h}</p>
      <p>Email:  {$customer->email}</p>
    </div>

    <div id="owner_info">
      <div><b>Owner: </b></div>
      <p>Name: Phuket car rental CO</p>
      <p>Phones:  thai: +6678940570</p>
      <p>Email: rentalcars@gmail.com</p>
    </div>

        <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Car Number</label>
                <div class="input-group ui-widget">
                  <input type="text" id="car_number" name="car_number" value="{$data.car_number}"  class="form-control" disabled=1>
                  <span class="input-group-addon"><i class="fa fa-car"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Mileage</label>
                <div class="input-group">
                    <input type="text" id="mileage" name="car_mileage" value="{$data.car_mileage}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-bug"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Data of Start</label>
                <div class="input-group">
                    <input name="date_start" class="datepicker form-control" value="{$contract->date_start}" type="text" disabled=1/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div> 
            <div class="col-xs-6 col-md-6">
                <label>Data of Finish</label>
                <div class="input-group">
                    <input name="date_stop" class="datepicker form-control" value="{$contract->date_stop}" type="text" disabled=1/>
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Time</label>
                <div class="input-group">
                    <input type="text" name="time" value="{$contract->time}" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Client Passport #</label>
                <div class="input-group">
                    <input type="text" id="passport" name="passport" value="" class="form-control" disabled=1>
                    <input type="hidden" name="client_id">
                    <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
                </div>  
            </div> 
            <div class="col-xs-6 col-md-6">
                <label>Client Name</label>
                <div class="input-group">
                    <input type="text" id="s_name" name="s_name" value="" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Nationality</label>
                <div class="input-group">
                    <input type="text" name="nationality" value="" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-flag"></i></span>
                </div>  
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone Russia</label>
                <div class="input-group">
                    <input type="text" id="phone_h" name="phone_h" value="" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Phone Thailand</label>
                <div class="input-group">
                    <input type="text" id="phone_m" name="phone_m" value= class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
                </div> 
            </div>
            <div class="col-xs-6 col-md-6">
                <label>E-mail</label>
                <div class="input-group">
                    <input type="text" id="email" name="email" value="" class="form-control" disabled=1>
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                </div>
            </div>
            <div class="col-xs-6 col-md-6">
                <label>Client Type</label>
                <select class="form-control system-add-price" name="client_type" disabled=1>
                    <option value="pauper">Pauper</option>
                    <option value="middle">Middle</option>
                    <option value="rich">Rich</option>
                </select>
            </div>
            
            <div class="col-xs-6 col-md-6">
                <label>Status</label>
                <div>{$contract->getStatusName()}</div>
            </div>
            
        </div>    

    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
      </ol>

      <!-- Wrapper for slides -->
      <div class="carousel-inner" role="listbox">
        {foreach $contract->getPhotos() as $num=>$photo}
          <div class="item {if $photo@iteration==1}active{/if}">
            <img src="{$data.path}{$photo}" />
          </div>
        {/foreach}
      </div>

      <!-- Controls -->
      <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>

        <div><a href="#" onClick="history.go(-1)"><strong>Back</strong></a></div>
    </div>