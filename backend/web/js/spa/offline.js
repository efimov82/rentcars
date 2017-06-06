// page loaded
$(function() {
  //javascript:initGeolocation();
  console.log( "ready!" );

  setInterval(function() {
    lib.Net.ChangeStatus();
  }, 30 * 1000); // 60 * 1000 milsec
	// online/offline event handler
	
  
  //if (window.sessionStorage) {
  // 	lib.Net.ChangeStatus();
	//	$(document).bind('online offline', lib.Net.ChangeStatus);
	//}
	
	// load data
	lib.Load();
  $("#sys_message").hide();
});

// online/offline library
var lib = lib || {};

lib.Net = function() {

	var online = true;

	// is browser online?
	function Online() { return navigator.onLine; }
	
	// online/offline event
	function ChangeStatus() {
		if (online != Online()) {
			online = Online();
			var s = $("#status");
			s.text(online ? "Online" : "Offline");
			if (online) {
        $(".menu1").show();
        s.removeClass("offline");
        
      } else { 
        //alert("You are OFFLINE. Data will save local.");
        
        // Most effect types need no options passed by default
        var options = {};// direction: 'right' 
        $("#sys_message").show('slide', options, 1000, hidePopMessage );
        
        s.addClass("offline");
        $(".menu1").hide();//attr("disabled", true);
      }
		}
	}
  
  function hidePopMessage() {
    setTimeout(function() {
      //$( "#sys_message:visible" ).removeAttr( "style" ).fadeOut();
      $( "#sys_message").hide('slide', {}, 1000);
    }, 5000 );
  }
	
	return {
		Online: Online,
		ChangeStatus: ChangeStatus
	};

}();

// save data online or offline
lib.Save = function(e) {

	e.preventDefault();
	
	if (lib.Net.Online() || !window.sessionStorage) {
	
		// save data online
		alert("Data has been saved online.\n(But not in this demo!)");
		
	}
	else {
	
		// save data offline
		$("#mainform input").each(function(i) {
			window.sessionStorage.setItem(this.id, this.value);
		});
		alert("Data has been saved offline.");

	}

};

// load data online or offline
lib.Load = function() {

	if (lib.Net.Online() || !window.sessionStorage) {
	
		// load data online
		//alert("Currently online:\ndata could be loaded from server.");
	
	}
	else {
	
		// load data offline
		$("#mainform input").each(function(i) {
			this.value = window.sessionStorage.getItem(this.id);
		});
		//alert("Data has been loaded from offline store.");

	}

};