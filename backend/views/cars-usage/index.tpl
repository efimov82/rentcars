<!-- header --!>
{include file="layouts/header.tpl"}
            <!-- page content --!>
            <div class="col-md-12">
                <h3>Cars usage</h3>
                <form action="" method="GET">
                    <div class="row">
                        {include file="shared/filters/dates.tpl" params=$params}
                        <div class="col-md-2">
                            <label>Car</label>
                            <div class="input-group col-md-12">
                                <input type="text" name="number" value="{if isset($params.number)}{$params.number}{/if}" class="search-query form-control"/>
                                
                            </div>
                        </div>
                        <div class="col-md-2">
                            <label>&nbsp;</label>
                            <button name="action" value="search" class="btn btn-info btn-block"><span class="glyphicon-search glyphicon"></span></span> Search</button>
                        </div>
                    </div>
                </form>
          </div> 
        </div>
        <hr>
        {if $data}
        <h3>Search results</h3>
          {if !$car_id} 
            {include file="table_all.inc.tpl" data=$data cars=$cars} 
          {else}
            {include file="car_calendar.inc.tpl" data=$data} 
          {/if}  
        {/if}
          