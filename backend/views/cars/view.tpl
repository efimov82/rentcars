{include file="layouts/header.tpl"}
            <!-- page content --!>
                <div class="col-md-6">
                <h3>Car details</h3>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Car Number</label>
                            <div class="input-group">
                                <input type="text" name="number" value="{$car->number}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div>  
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Brand</label>
                            <div class="input-group">
                                <input type="text" name="mark" value="{$car->mark}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div>  
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Model</label>
                            <div class="input-group">
                                <input type="text" name="model" value="{$car->model}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div>  
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Color</label>
                            <div class="input-group">
                                <input type="text" name="color" value="{$car->color}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-paint-brush"></i></span>
                            </div>  
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Start of Lease</label>
                            <div class="input-group">
                                <input name="start_lease" value="{$car->start_lease}" class="datepicker form-control" type="text"/>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div>                    
                        <div class="col-xs-6 col-md-6">
                            <label>Mileage</label>
                            <div class="input-group">
                                <input type="text" name="mileage" value="{$car->mileage}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-bug"></i></span>
                            </div>  
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Paid up to</label>
                            <div class="input-group">
                                <input name="paid_up_to" value="{$car->paid_up_to}" class="datepicker form-control" type="text"/>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            </div>
                        </div> 
                        <div class="col-xs-6 col-md-6">
                            <label>Price</label>
                            <div class="input-group">
                                <input name="price" value="{$car->price}" type="text" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                            </div> 
                        </div>
                    </div>
                    <div class="row">
                      <div class="col-xs-6 col-md-6">
                        <label>Year</label>
                        <div class="input-group">
                          <input name="year" value="{$car->year}" class="form-control" type="text"/>
                          <span class="input-group-addon"><i class="fa fa-bug"></i></span>
                        </div>
                      </div>
                      <div class="col-xs-6 col-md-6">
                        <label>Status</label>
                        <div class="input-group">
                          {html_options name="status" options=$statuses selected=$car->status class="form-control"}
                        </div>
                      </div>
                    </div>
                </div>