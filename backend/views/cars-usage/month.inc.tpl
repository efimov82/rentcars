<div class="month">      
  <ul>
    <li style="text-align:center">
      {$name}
    </li>
  </ul>
</div>

<ul class="weekdays">
  <li>Mo</li>
  <li>Tu</li>
  <li>We</li>
  <li>Th</li>
  <li>Fr</li>
  <li>Sa</li>
  <li><b>Su</b></li>
</ul>

<ul class="days">
  {foreach $days as $day_arr}
  <li><span {if $day_arr.state==2}class="active"{/if}>{$day_arr.day}</span></li>
  {/foreach}
</ul>
