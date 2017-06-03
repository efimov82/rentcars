<!-- header --!>
{include file="layouts/header.tpl"}
            <!-- page content --!>
            <div class="col-md-6">
                <h3>Users List</h3>
            </div>    
        </div>
        <div class="table-responsive table-full-width">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Login</th>
                        <th>Phone</th>
                        <th>Phone</th>
                        <th>E-mail</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                {foreach $users as $num=>$user}
                    <tr>
                        <td>#{$user->id}</td>
                        <td>{$user->name}</td>
                        <td>{$user->username}</td>
                        <td>715666280</td>
                        <td>123123</td>
                        <td>{$user->email}</td>
                        <td><a href="{url route='users/edit' id=$user->id}"><button class="btn btn-info btn-xs"><i class="fa fa-pencil-square-o"></i> Edit</button></a>
                    </tr>
                    {/foreach}
                </tbody>
            </table>