{include file="layouts/header.tpl"}
            <!-- page content --!>
            <form action="/cars/save" method="POST">
                <div class="col-md-6">
                <h3>Edit Сar</h3>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Car Number</label>
                            <div class="input-group">
                                <input type="hidden" name="id" value="{$car->id}">
                                <input type="text" name="number" value="{$car->number}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div>  
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Owner</label>
                               {html_options name="owner_id" options=$owners selected=$car->owner_id class="form-control"} 
                        </div>
                        
                    </div>
                    <div class="row">
                      <div class="col-xs-6 col-md-6">
                          <label>Brand</label>
                          <div class="input-group">
                              <input type="text" name="mark" value="{$car->mark}" class="form-control">
                              <span class="input-group-addon"><i class="fa fa-car"></i></span>
                          </div>  
                      </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Model</label>
                            <div class="input-group">
                                <input type="text" name="model" value="{$car->model}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-car"></i></span>
                            </div>  
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Color</label>
                            <div class="input-group">
                                <input type="text" name="color" value="{$car->color}" class="form-control">
                                <span class="input-group-addon"><i class="fa fa-paint-brush"></i></span>
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
                        <label>Year</label>
                        <div class="input-group">
                          <input name="year" value="{$car->year}" class="form-control" type="text"/>
                          <span class="input-group-addon"><i class="fa fa-bug"></i></span>
                        </div>
                      </div>  
                      <div class="col-xs-6 col-md-6">
                        <label>Status</label>
                        {html_options name="status" options=$statuses selected=$car->status class="form-control"}
                      </div>
                    </div>
                    <label>Add Files</label>
                    <div class="input-group">
                        <label class="input-group-btn"><span class="btn btn-fill">Browse<input type="file" style="display: none;" multiple></span></label>
                        <input type="text" name="image1" class="form-control" readonly>
                    </div>
                    {include file='layouts/panel.tpl' id=$car->id}
                </div>
            </form>