<!-- header --!>
{include file="layouts/header.tpl"}

  <!-- page content --!>
  <div class="col-md-8">
    <h3>Reports</h3>
  </div>  

  <!-- search form -->
    <div>
      <form action="/reports">
        <div class="input-group col-md-12">
            Date from: <input type="text" name="date1" value="" class="form-control" />
        </div>
        <div class="input-group col-md-12">
          Date to: <input type="text" name="date2" value="" class="form-control" />
        </div>
        <div class="input-group col-md-12">
          User: <input type="text" name="user" value="" class="form-control" />
        </div>
        <div class="input-group col-md-12">
          Car#: <input type="text" name="car" value="" class="form-control" />
        </div>
        <div class="input-group col-md-12">
          Type payments#: <select>
                              <option value="1">INCOME</option>
                              <option value="2">OUTGOING</option>
                          </select>
          Status payments#: <select>
                              <option value="1">NEW</option>
                              <option value="2">CONFIRM</option>
                              <option value="4">UNPAID</option>
                          </select>
        </div>
        <div class="input-group col-md-12">
          Category payments#: <select>
                              <option value="1">ALL</option>
                              <option value="2">Rent</option>
                              <option value="3">Deposit</option>
                              <option value="4">Repair</option>
                          </select>
        </div>
        <input type="submit" value="Seach" />
      </form> 
    </div>

  <!-- results -->
  <div>
    <div>
      <h3>Results of search</h3>
    </div>
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