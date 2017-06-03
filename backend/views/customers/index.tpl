<!-- header --!>
{include file="layouts/header.tpl"}
            <!-- page content --!>
            <div class="col-md-6">
                <h3>Customers list</h3>
            </div>    
            <div class="col-md-offset-4 col-md-2">
                <div id="custom-search-input">
                    <form action="/cars" method="GET">
                    <label>Search by number:</label>
                         <div class="input-group col-md-12">
                            <input type="text" name="number" value="" class="search-query form-control"/>
                            <span class="input-group-btn"><button class="btn btn-info" type="submit"><span class="fa fa-search"></span></button></span>
                         </div>
                    </form> 
                </div>
            </div>
        </div>
        <div class="table-responsive table-full-width">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Phone</th>
                        <th>Phone</th>
                        <th>E-mail</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $customers as $num=>$customer}
                    <tr>
                        <td>#{$customer->id}</td>
                        <td>{$customer->f_name} {$customer->s_name} {$customer->l_name}</td>
                        <td>{$customer->phone_h}</td>
                        <td>{$customer->phone_m}</td>
                        <td>{$customer->email}</td>
                        <td><a href="{url route="customers/edit" id=$customer->id}"><button class="btn btn-info btn-xs"><i class="fa fa-pencil-square-o"></i> Edit</button></a></td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
          </div>