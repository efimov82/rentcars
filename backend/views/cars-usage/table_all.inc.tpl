<div class="table-responsive table-full-width">
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
              <td><a href="{$base_url}&car_id={$car_id}">Calendar</a></td>
              <td>{($sum_rent_days/$count_days *100)|round:2}%</td>
          </tr>
        {/foreach}
      </tbody>  
  </table>
</div>