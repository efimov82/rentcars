<!-- header --!>
{include file="layouts/header.tpl"}
            <!-- page content --!>
            <div class="col-md-6">
                <h3>Customers list</h3>
            </div>    
            <div class="col-md-offset-4 col-md-2">
                <div id="custom-search-input">
                    <form action="" method="GET">
                    <label>Search:</label>
                         <div class="input-group col-md-12">
                            <input type="text" name="str_search" value="{$params.str_search}" class="search-query form-control"/>
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
                        <th>Phone Rus</th>
                        <th>Phone Thai</th>
                        <th>E-mail</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                {$str = $params.str_search}
                
                {$res = "<span class=\"sub_str_search\">$str</span>"}
                {foreach $customers as $num=>$customer}
                    <tr>
                        <td>#{$customer->id}</td>
                        <td>{$customer->f_name|regex_replace:"/$str/": $res} 
                            {$customer->s_name|regex_replace:"/$str/": $res} 
                            {$customer->l_name|regex_replace:"/$str/": $res}</td>
                        
                        <td><a href="skype:{$customer->phone_h}?call">{$customer->phone_h|regex_replace:"/$str/": $res}</a></td>
                        <td><a href="skype:{$customer->phone_m}?call">{$customer->phone_m|regex_replace:"/$str/": $res}</a></td>
                        <td><a href="mailto:{$customer->email}">{$customer->email|regex_replace:"/$str/": $res}</a></td>
                        <td><a href="{url route="/contracts" customer_id=$customer->id}"><button class="btn btn-info btn-xs"><i class="fa fa-pencil-square-o"></i> Contracts</button></a></td>
                        <td><a href="{url route="customers/edit" id=$customer->id}"><button class="btn btn-info btn-xs"><i class="fa fa-pencil-square-o"></i> Edit</button></a></td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
          </div>

{literal}
<style>
.sub_str_search {
    color: red;
} 
</style>
{/literal}