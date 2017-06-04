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

<button onclick="getLocation()">Try It</button>

<p id="demo"></p>

{literal}

 <script>
var x = document.getElementById("demo");
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}
function showPosition(position) {
    x.innerHTML = "Latitude: " + position.coords.latitude +
    "<br>Longitude: " + position.coords.longitude;
}
</script> 
{/literal}
</div>