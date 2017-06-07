<script src="/js/bootstrap-year-calendar.min.js"></script>

<script src="/js/spa/calendar.js?v=2"></script>

<script type="text/javascript">
  var dataSourse = [
    {foreach $data as $num=>$arr}
      {
          id: {$num},
          name: 'Contract #{$arr.id}',
          location: '{$arr.date_start|date_format:"d.m.y"} - {$arr.date_stop|date_format:"d.m.y"}',
          startDate: new Date({$arr.date_start|date_format:"Y"},{$arr.date_start|date_format:"m"-1},{$arr.date_start|date_format:"d"}),
          endDate: new Date({$arr.date_stop|date_format:"Y"},{(int)$arr.date_stop|date_format:"m"-1},{$arr.date_stop|date_format:"d"})
      },
    {/foreach}
    ];
</script>

<span id="calendar"></span>


<h4><b>List contracts</b></h4>
      <div class="table-responsive table-full-width">
        <table class="table table-hover">
          <thead>
            <th>ID</th>
            <th>Dates</th>
            <th>&nbsp;</th>
          </thead>
          <tbody>
            {$last_date = ''}
            {foreach $data as $num=>$arr}
              {if !$last_date}{$last_date=$arr.date_stop}{/if}
                {$res = ($arr.date_start|strtotime < $last_date|strtotime)}
              <tr{if $res == 1} class="warning"{/if}>
                <td>{$arr.id}</td>
                <td>{$arr.date_start|date_format:"d.m.y"} - {$arr.date_stop|date_format:"d.m.y"}</td>
                <td><a href="{url route="/contracts/edit" id=$arr.id}">Edit</a></td>
              </tr>
              {$last_date=$arr.date_stop}
            {/foreach}
          <tbody>
        </table>
      </div>

