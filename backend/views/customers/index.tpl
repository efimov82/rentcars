<!-- header --!>
{include file="layouts/header.tpl"}

<!-- page content --!>
  <div class="col-md-8">
    <h3>Customers list</h3>
  </div>    

</div>
       <div class="content table-responsive table-full-width">
            <table class="table table-hover">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Name</th>
                  <th>Thai Phone</th>
                  <th>Rus Phone</th>
                  <th>E-mail</th>
                  <th>&nbsp;</th>
                </tr>
              </thead>
              <tbody>
                {foreach $customers as $num=>$customer}
                <tr>
                  <td>#{$customer->id}</td>
                  <td>{$customer->f_name} {$customer->s_name} {$customer->l_name}</td>
                  <td>{$customer->phone_m}</td>
                  <td>{$customer->phone_h}</td>
                  <td>{$customer->email}</td>
                  <td><a href="{url route="customers/edit" id=$customer->id}"><button class="btn btn-fill btn-xs"><i class="fa fa-pencil-square-o"></i>Edit</button></a></td>
                </tr>
                {/foreach}
              </tbody>
            </table>
          </div>