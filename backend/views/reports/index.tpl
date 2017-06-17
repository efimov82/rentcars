<!-- header --!>
{include file="layouts/header.tpl"}
    <!-- page content --!>
        <div class="col-md-12">
        <!-- search form -->
            <h3>Reports</h3>
            <form action="" method="POST">
                <div class="row">
                    {include file="shared/filters/dates.tpl" params=$params}
                    <div class="col-xs-6 col-md-2">
                        <label>Car:</label>
                        <div class="input-group">
                            <input type="text" name="car_number" value="{if isset($params.car_number)}{$params.car_number}{/if}" class="form-control" />
                            <span class="input-group-addon">#</span>
                        </div> 
                    </div> 
                    {include file="shared/filters/managers.tpl" managers=$managers params=$params}
                    <div class="col-xs-6 col-md-2">
                        <label>Category:</label> 
                        <select name="payment_category" class="form-control">
                            <option value="0"  class="form-control option">ALL</option>
                            {foreach $categories as $num=>$arr}
                            <option value="{$arr.id}" class="form-control option"{if $arr.id == $params.payment_category} selected="selected"{/if}>{$arr.name}</option>
                        {/foreach}
                        </select>
                    </div>
                    {include file="shared/filters/payment_types.tpl" params=$params}
                    <div class="col-xs-6 col-md-1">
                        <label>Status:</label>
                        {html_options name="payment_status" options=$payments_statuses emptyoption="ALL" selected=$params.payment_status class="form-control"}
                    </div>
                </div>
                <div class="row">
                    {foreach $group_by_list as $val=>$name}
                    <div class="col-xs-6 col-md-1">
                        <div class="checkbox">
                        <label>
                          <input name="group_by[]" value="{$val}" type="checkbox" {if isset($params['group_by'][$val])}checked="checked"{/if}> {$name}
                        </label>
                        </div>
                    </div> 
                    {/foreach}
                    <div class="col-md-offset-5 col-xs-12 col-md-1">
                        <button name="action" value="search" class="btn btn-info btn-block"><span class="glyphicon-search glyphicon"></span></span> Search</button>
                    </div>
                </div>    
            </form>
        <!-- results -->
        <hr>
        {if $params.hasPost}
            <h3>Search results</h3>
            {if $results}
            <div class="table-responsive table-full-width">
                <table class="table table-hover">
                    <thead>
                        <th>#</th>
                        <th>Date</th>
                        {if isset($params.group_by.users)}<th>User</th>{/if}
                        {if isset($params.group_by.cars)}<th>Car #</th>{/if}
                        {if isset($params.group_by.types)}<th>Type</th>{/if}
                        {if isset($params.group_by.categories)}<th>Category</th>{/if}
                        {if isset($params.group_by.statuses)}<th>Status</th>{/if}
                        <th>THB</th>
                        <th>USD</th>
                        <th>EURO</th>
                        <th>RUB</th>
                    </thead>
                    <tbody>
                        {$all_thb=0}
                        {$all_usd=0}
                        {$all_euro=0}
                        {$all_ruble=0}
                        {foreach $results as $num=>$data}
                        <tr  {if ($data.type_id == 1)}class="success"{else}class="danger"{/if}>
                            <td>{$data@iteration}</td>
                            <td>{if isset($params.group_by.days)}{$data.date|date_format:"d/m"}{else}&nbsp;{/if}</td>
                            {if isset($params.group_by.users)}<td>{$managers[$data.user_id].name}</td>{/if}
                            {if isset($params.group_by.cars)}<td>{if isset($cars[$data.car_id])}{$cars[$data.car_id].number}{/if}</td>{/if}
                            {if isset($params.group_by.types)}<td>{if $data.type_id == 1}+{else}-{/if}</td>{/if}
                            {if isset($params.group_by.categories)}<td>{$categories[$data.category_id].name}</td>{/if}
                            {if isset($params.group_by.statuses)}<td>{$payments_statuses[$data.status]}</td>{/if}
                            <td>{$data.sum_thb}</td>
                            <td>{$data.sum_usd}</td>
                            <td>{$data.sum_euro}</td>
                            <td>{$data.sum_ruble}</td>
                            {$all_thb = $all_thb + $data.sum_thb}
                            {$all_usd = $all_usd + $data.sum_usd}
                            {$all_euro = $all_euro + $data.sum_euro}
                            {$all_ruble = $all_ruble + $data.sum_ruble}
                        </tr>
                        {/foreach}
                        <tr class="alert alert-info">
                            <td><strong>TOTAL ({$results|count})</strong></td>
                            <td>&nbsp;</td>
                            {if isset($params.group_by.users)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.cars)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.types)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.categories)}<td>&nbsp;</td>{/if}
                            {if isset($params.group_by.statuses)}<td>&nbsp;</td>{/if}
                            <td><strong>{$all_thb|number_format:0}</strong></td>
                            <td><strong>{$all_usd|number_format:0}</strong></td>
                            <td><strong>{$all_euro|number_format:0}</strong></td>
                            <td><strong>{$all_ruble|number_format:0}</strong></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            {else}
              <div>Empty result of search</div>
            {/if}
        </div>
        {/if}