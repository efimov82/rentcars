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

<button onclick="checkLocation();">Try It</button>
<div id="map"></div>

{literal}

<div>
        <script src="http://maps.google.com/maps?hl=it&amp;file=api&amp;v=2&amp;sensor=true&amp;" type="text/javascript"></script>
<script type="text/javascript">
  
    var map;
    var geocoder;

    function addAddressToMap(response) 
    {
        if (!response || response.Status.code != 200) 
        {
            alert("Sorry, we were unable to geocode that address");
        } 
        else 
        {
            place = response.Placemark[0];
            point = new GLatLng(place.Point.coordinates[1], place.Point.coordinates[0]);
            document.getElementById('address').innerHTML = place.address;
            var str = place.address
            var a = str.lastIndexOf(",")
            a = a + 1
            var country = str.substring(a)
            document.getElementById('country').innerHTML=country
            document.getElementById('Label1').innerHTML = country
          
        }
    }


    function searchGeolocation() 
    {
        if (navigator.geolocation) 
        {
            navigator.geolocation.getCurrentPosition(function(position) 
            {  
                geocoder = new GClientGeocoder();
                document.getElementById('latitude').innerHTML = position.coords.latitude;
                document.getElementById('longitude').innerHTML = position.coords.longitude;
                coordinates = position.coords.latitude+","+position.coords.longitude;
                geocoder.getLocations(coordinates, addAddressToMap);
                
            }); 
        }else
        {
            document.getElementById('latitude').innerHTML = "Unknown";
            document.getElementById('longitude').innerHTML = "Unknown";
            document.getElementById('address').innerHTML = "Unknown";
            alert("I'm sorry, but geolocation services are not supported by your browser.");    
        }
    }


</script>





  <script>
    var map;
    function initMap() {
      map = new google.maps.Map(document.getElementById('map'), {
        zoom: 2,
        center: new google.maps.LatLng(2.8,-187.3),
        mapTypeId: 'terrain'
      });

      // Create a <script> tag and set the USGS URL as the source.
      var script = document.createElement('script');
      // This example uses a local copy of the GeoJSON stored at
      // http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_week.geojsonp
      script.src = 'https://developers.google.com/maps/documentation/javascript/examples/json/earthquake_GeoJSONP.js';
      document.getElementsByTagName('head')[0].appendChild(script);
    }
    </script>


<script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDBZ5i0oF1WeuNvwodEGAtn880Fh0Bq8Co&callback=initMap">
    </script>

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

<div>