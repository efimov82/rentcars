/* 
 * Inner functions
 */


// Init datePicker for search
$('#date_start').datepicker({
  format: 'dd.mm.yyyy',
  weekStart: 1
}).on('changeDate', function(ev){
  var date_stop = $('#date_stop');
  var start = moment(ev.date, 'x');
  var stop = moment(toDate(date_stop.val()), 'x');
  
  if (start > stop) {
    stop = moment(ev.date).add(1, 'days').format('DD.MM.YYYY');
    date_stop.val(stop);
  }
});

// date stop datapicker    
$('#date_stop').datepicker({
  format: 'dd.mm.yyyy',
  weekStart: 1
}).on('changeDate', function(ev){
    var date_start = $('#date_start');
    var start = moment(toDate(date_start.val()), 'x');
    var stop = moment(ev.date, 'x');
    
    if (start > stop) {
      start = moment(ev.date).subtract(1, 'days').format('DD.MM.YYYY');
      date_start.val(start);
    }
  
      //start = moment(ev.date).subtract(1, 'days').format('DD.MM.YYYY');
      //$('#date_start').val(start);
      //}
  });


// format: d.m.YY
// return Date
function toDate(dateStr) {
    var parts = dateStr.split(".");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}

