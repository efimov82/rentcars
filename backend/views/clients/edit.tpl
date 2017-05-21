{include file="layouts/header.tpl"}

<!-- page content --!>
<h3>Edit client data</h3>

 <div class="row">
            <div class="col-xs-6 col-md-6">
              <label>First Name</label>
              <div class="input-group">
                <input type="text" class="form-control">
                <span class="input-group-addon"><i class="fa fa-user"></i></span>
              </div>  
            </div>
            <div class="col-xs-6 col-md-6">
              <label>Last Name</label>
              <div class="input-group">
                <input type="text" class="form-control">
                <span class="input-group-addon"><i class="fa fa-user"></i></span>
              </div>  
            </div> 
            <div class="col-xs-6 col-md-6">
              <label>Passport#</label>
              <div class="input-group">
                <input type="text" class="form-control">
                <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
              </div>  
            </div> 
            <div class="col-xs-6 col-md-6">
              <label>Nationality</label>
              <div class="input-group">
                <input type="text" value="RUS" class="form-control">
                <span class="input-group-addon"><i class="fa fa-flag"></i></span>
              </div>  
            </div> 
            <div class="col-xs-6 col-md-6">
              <label>Data of Birth</label>
              <div class="input-group">
              <input class="datepicker form-control" type="text"/>
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
              </div>
            </div> 
            <div class="col-xs-6 col-md-6">
              <label>Place of Birth</label>
              <div class="input-group">
                <input type="text" class="form-control">
                <span class="input-group-addon"><i class="fa fa-university"></i></span>
              </div>  
            </div>
          </div>

          <div class="row">
            <div class="col-xs-6 col-md-6">
              <label>Mobile Phome</label>
              <div class="input-group">
                <input type="text" value="+7" class="form-control">
                <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
              </div>  
            </div>
            <div class="col-xs-6 col-md-6">
              <label>Home Phone</label>
              <div class="input-group">
                <input type="text" value="+66" class="form-control">
                <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
              </div> 
            </div>
            <div class="col-xs-6 col-md-6">
              <label>E-mail</label>
              <div class="input-group">
                <input type="text" class="form-control">
                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
              </div> 
            </div>
            <div class="col-xs-6 col-md-6">
              <label>Sex</label>
              <select class="form-control system-add-price" name="Sex">
                <option data="male" value="Male">Male</option>
                <option data="female" value="Woman">Female</option>
              </select>
            </div>
          </div>

          <div class="row">
            <div class="col-xs-6 col-md-6">
                <label>Add Files</label>
                <div class="input-group">
                    <label class="input-group-btn">
                      <span class="btn btn-fill">Browse<input type="file" style="display: none;" multiple></span>
                    </label>
                    <input type="text" class="form-control" readonly>
                </div>
            </div>
          </div>

          <div class="row">
            <div class="tim-title">
              <div class="col-md-2">
                <button href="#fakelink" class="btn btn-block">Safe</button>
              </div>
            </div>
            {if $client->id}
            <div class="tim-title">
              <div class="col-md-2">
                <a href="{url route="/cars/delete/{$client->id}"}"><button class="btn btn-block">Delete</button></a>
              </div>
            </div>
            {/if}
            <div class="tim-title">
              <div class="col-md-2">
                <a href="{url route="/cars"}"><button class="btn btn-block">Cancel</button></a>
              </div>
            </div>
          </div>

        </div>