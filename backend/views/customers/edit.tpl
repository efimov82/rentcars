<!-- header --!>
{include file="layouts/header.tpl"}
            <!-- page content --!>
            <form action="/customers/save" method="POST">
                <input type="hidden" name="id" value="{$customer->id}">
                <div class="col-md-6">  
                    <h3>Add / Edit Customer</h3>
                    <div class="row">
                        <div class="col-xs-6 col-md-6">
                            <label>Family name</label>
                            <div class="form-group input-group">
                                <input class="form-control" type="text" name="f-name" value="{$customer->f_name}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Last name</label>
                            <div class="form-group input-group">
                                <input class="form-control" type="text" name="l-name" value="{$customer->l_name}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Passport #</label>
                            <div class="form-group input-group">
                                <input class="form-control" type="text" name="passport" value="{$customer->passport}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-qrcode"></span></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Nationality</label>		
                            <div class="form-group input-group">
                                <input class="form-control" type="text" name="nationality" value="{$customer->nationality}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-flag"></span></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>First phone</label>		
                            <div class="form-group input-group">
                                <input class="form-control" type="text" name="phone_m" value="{$customer->phone_m}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-earphone"></span></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Second phone</label>		
                            <div class="form-group input-group">
                                <input class="form-control" type="text" name="phone_h" value="{$customer->phone_h}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-earphone"></span></span>
                            </div>
                		</div>                		
                        <div class="col-xs-6 col-md-6">
                            <label>Email</label>
                            <div class="form-group input-group">
                                <input class="form-control" type="email" name="email" value="{$customer->email}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Facebook page</label>
                            <div class="form-group input-group">
                                <input class="form-control" type="text" name="facebook" value="{$customer->facebook}">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-link"></span></span>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Add Files</label>
                            <div class="input-group">
                                <label class="input-group-btn"><span class="btn btn-info">Browse<input type="file" name="files[]" style="display: none;" multiple></span></label>
                                <input type="text" name="image1" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Tupe client</label>
                            <select name="tupe" class="form-control">
                                <option value="23">2CarRenr</option>
                                <option value="2">admin</option>
                                <option value="5">bagrat</option>
                                <option value="24">bagrat2</option>
                                <option value="19">Chai</option>
                                <option value="28">dan82</option>
                            </select>
                        </div>
                        <div class="clearfix"></div>
{include file='layouts/panel.tpl' id=$customer->id}
                    </div>
                </form>