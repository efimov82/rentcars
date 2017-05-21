<!-- header --!>
{include file="layouts/header.tpl"}
  <!-- page content --!>
    <div class="col-md-12">
    <!-- search form -->
        <h3>Reports</h3>
        <form action="/reports">
            <div class="row">
                <div class="col-xs-6 col-md-3">
                    <label>Date from:</label>
                    <div class="input-group">
                        <input name="date_start" class="datepicker form-control" value="" type="text"/>
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div> 
                </div>
                <div class="col-xs-6 col-md-3">
                    <label>Date to:</label>
                    <div class="input-group">
                        <input name="date_start" class="datepicker form-control" value="" type="text"/>
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div> 
                </div> 
                <div class="col-xs-6 col-md-3">
                    <label>User:</label>
                    <div class="input-group">
                        <input type="text" name="user" value="" class="form-control" />
                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    </div> 
                </div>                
                <div class="col-xs-6 col-md-3">
                    <label>Car:</label>
                    <div class="input-group">
                        <input type="text" name="car" value="" class="form-control" />
                        <span class="input-group-addon"><i class="fa fa-car"></i></span>
                    </div> 
                </div>  
            </div>
            <div class="row">
                <div class="col-md-3">
                    <label>Type payments#:</label> 
                    <select name="type payments" class="form-control">
                        <option value="1" class="form-control option">INCOME</option>
                        <option value="2" class="form-control option">OUTGOING</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label>Status payments#:</label>
                    <select name="status payments" class="form-control">
                        <option value="1" class="form-control option">NEW</option>
                        <option value="2" class="form-control option">CONFIRM</option>
                        <option value="3" class="form-control option">UNPAID</option>
                        <option value="4" class="form-control option">Repair</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label>Category payments#:</label> 
                    <select name="category payments" class="form-control">
                        <option value="1" class="form-control option">ALL</option>
                        <option value="2" class="form-control option">Rent</option>
                        <option value="3" class="form-control option">Deposit</option>
                        <option value="4" class="form-control option">Repair</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label>Type payments#:</label> 
                    <select name="type payments" class="form-control">
                        <option value="1" class="form-control option">INCOME</option>
                        <option value="2" class="form-control option">OUTGOING</option>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">
                    <div class="tim-title">
                        <button name="action" value="seach" class="btn btn-block"><i class="fa fa-search"></i> Seach</button>
                    </div>
                </div>
            </div>    
        </form> 
    </div>
                
    <!-- results -->
    <div class="col-md-12">
        <h3>Results of search</h3>
        <table>
            <thead>
                <th>#</th>
                <th>date</th>
                <th>user</th>
                <th>thb</th>
                <th>usd</th>
                <th>eur</th>
                <th>rub</th>
            </thead>
            <tbody>
                <tr>
                    <td>#</td>
                    <td>date</td>
                    <td>user</td>
                    <td>thb</td>
                    <td>usd</td>
                    <td>eur</td>
                    <td>rub</td>
                </tr>
                <tr>
                    <td><b>TOTAL</b></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>SUM</td>
                    <td>SUM</td>
                    <td>SUM</td>
                    <td>SUM</td>
                </tr>
            </tbody>
        </table>
    </div>