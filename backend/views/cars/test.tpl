{include file="layouts/header.tpl"}
            <!-- page content -->

<div>
  <p>isMobile: {$detecter->isMobile()}</p>

<p>version iPad={$detecter->version('iPad')}</p>
<p>version iOS={$detecter->version('iPhone')}</p>
<p>version Android={$detecter->version('Android')}</p>
</div>

COORDS

<p>Click the button to get your coordinates.</p>


<button onClick="checkLocation()">Try It!!!</button>

<div id="demo"></div>

{literal}


<script src='https://maps.googleapis.com/maps/api/jscallback=initMap&signed_in=true&key=AIzaSyBIiiYu72Id3JCTGb5jd8QarmgElxoTxQo' async defer></script>


<script>

var options = {
  enableHighAccuracy: true,
  timeout: 30000,
  maximumAge: 75000
};

function success(pos) {
  var crd = pos.coords;
  var demo = $('#demo');
  
alert('latid='+crd.latitude);
  //demo.text('Your current position is:\n Latitude : ' + crd.latitude +
  //          'Longitude: ' + crd.longitude +
   //         'More or less ' + crd.accuracy + 'meters');
};

function error(err) {
  alert('ERROR code='+err.code+', message='+err.message);
};

function checkLocation() {
  navigator.geolocation.getCurrentPosition(success, error, options);
};

</script> 

{/literal}
</div>
