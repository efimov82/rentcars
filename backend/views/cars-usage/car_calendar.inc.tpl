<script src="/js/bootstrap-year-calendar.min.js"></script>

<script src="/js/spa/calendar.js?v=2"></script>

<script type="text/javascript">
  var dataSourse = [
    {foreach $data as $num=>$arr}
      {
          id: {$num},
          name: 'Contract #{$arr.id}',
          location: '{$arr.date_start|date_format:"d.m.y"} - {$arr.date_stop|date_format:"d.m.y"}',
          startDate: new Date({$arr.date_start|date_format:"Y, m, d"}),
          endDate: new Date({$arr.date_stop|date_format:"Y, m, d"})
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
            {foreach $data as $num=>$arr}
              <tr>
                <td>{$arr.id}</td>
                <td>{$arr.date_start|date_format:"d.m.y"} - {$arr.date_stop|date_format:"d.m.y"}</td>
                <td><a href="{url route="/contracts/edit" id=$arr.id}">Edit</a></td>
              </tr>
            {/foreach}
          <tbody>
        </table>
      </div>

