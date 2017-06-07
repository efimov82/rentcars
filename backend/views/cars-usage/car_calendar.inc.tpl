<script src="/js/bootstrap-year-calendar.min.js"></script>

<script src="/js/spa/calendar.js"></script>
<reference path="/js/bootstrap-year-calendar.d.ts"/>

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
<span id="event-modal"></span>


