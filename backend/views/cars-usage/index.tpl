<!-- header --!>
{include file="layouts/header.tpl"}

<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});
</script>

  <!-- page content --!>
  <div class="col-md-12">
    <h3>Cars usage</h3>

      <div>
        <form action="" method="POST">
            <div class="row">
                <div class="col-xs-6 col-md-3">
                    <label>Date from:</label>
                    <div class="input-group">
                        <input name="date_start" class="datepicker form-control" value="{if isset($params.date_start)}{$params.date_start|date_format:"%Y-%m-%d"}{/if}" type="text"/>
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div> 
                </div>
                <div class="col-xs-6 col-md-3">
                    <label>Date to:</label>
                    <div class="input-group">
                        <input name="date_stop" class="datepicker form-control" value="{if isset($params.date_stop)}{$params.date_stop|date_format:"%Y-%m-%d"}{/if}" type="text"/>
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div> 
                </div> 
            </div> 
            
            <div class="row">
              <div class="col-md-2">
                <div class="tim-title">
                  <button name="action" value="search" class="btn btn-block"><i class="fa fa-search"></i>Search</button>
                </div>
              </div>
            </div>

        </form>
      </div> 
  </div> 
</div>

<div class="row">

{if $data}
<div class="content table-responsive table-full-width">
  <table class="table table-hover">
    <thead>
      <tr>
        <td>Car#</td>
        <td>Usages</td>
        <td>Relevance %</td>
      </tr>
    </thead>
    <tbody>
      {foreach $data as $car_id=>$arr}
        <tr>
          <td>#{$cars[$car_id].number}</td>
          <td>
            <nobr>
            {$koeff = (int)(800 / $count_days)}
            {$sum_rent_days = 0}
            {foreach $arr as $num=>$period}
              {if $period.type==1}
                {$color="green"}
                {$sum_rent_days=$sum_rent_days+$period.days}
              {/if}
              {if $period.type==2}{$color="red"}{/if}
              {if $period.type==3}{$color="grey"}{/if}
              {if $period.contract_id}
              <a href="/contracts/view/{$period.contract_id}" target="_blank" data-toggle="tooltip" data-placement="bottom" data-html=true
                      title="<b>Contract:</b> #{$period.contract_id}<br/>
                                   {$period.date_start|date_format:"%d/%m/%y"}-{$period.date_stop|date_format:"%d/%m/%y"}<br/>
                                  <strong>Rent days</strong>: {$period.all_days}">
                <img src="/img/g1.gif"><img src="/img/{$color}10x10.jpg" width="{$period.days * $koeff}px" height="20px"/><img src="/img/g2.gif">
              </a>
              {else}
                <img src="/img/{$color}10x10.jpg" width="{$period.days * $koeff}px" height="20px" title="days {$period.all_days}"/>
              {/if}
            {/foreach}
            </nobr>
          </td>
          <td>{($sum_rent_days/$count_days *100)|round:2}%</td>
        </tr>
      {/foreach}
    </tbody>  
</table>
{/if}

</div>