$(function() {
  
  var currentYear = new Date().getFullYear();
  
  function editContract(event) {
    $('#event-modal input[name="event-index"]').val(event ? event.id : '');
    $('#event-modal input[name="event-name"]').val(event ? event.name : '');
    $('#event-modal input[name="event-location"]').val(event ? event.location : '');
    $('#event-modal input[name="event-start-date"]').datepicker('update', event ? event.startDate : '');
    $('#event-modal input[name="event-end-date"]').datepicker('update', event ? event.endDate : '');
    $('#event-modal').modal();
  }

    
  $('#calendar').calendar({
    enableContextMenu: true,
    
    contextMenuItems:[
        {
            text: 'Update',
            click: editContract
        }
//        {
//            text: 'Delete',
//            click: deleteEvent
//        }
    ] ,

    mouseOnDay: function(e) {
        if(e.events.length > 0) {
            var content = '';

            for(var i in e.events) {
                content += '<div class="event-tooltip-content">'
                                + '<div class="event-name" style="color:' + e.events[i].color + '">' + e.events[i].name + '</div>'
                                + '<div class="event-location">' + e.events[i].location + '</div>'
                            + '</div>';
            }

            $(e.element).popover({
                trigger: 'manual',
                container: 'body',
                html:true,
                content: content
            });

            $(e.element).popover('show');
        }
    },
    mouseOutDay: function(e) {
        if(e.events.length > 0) {
            $(e.element).popover('hide');
        }
    },
    dayContextMenu: function(e) {
        $(e.element).popover('hide');
    },
    dataSource: dataSourse
  });

});