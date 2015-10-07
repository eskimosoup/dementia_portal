var map;
var resources;
var latLngs = [];
var latlngbounds;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 53.7443, lng: 0.3325},
    zoom: 8
  });

  latlngbounds = new google.maps.LatLngBounds();

  resources = $('.resource').map(function() {
    return $(this).data();
  });

  $.each(resources, function(index, resource){
    var marker = addMarker(resource, map);
    var infoWindow = addInfoWindow(resource);
    var latLng = marker.getPosition(); // returns LatLng object
    latLngs.push(latLng);
    marker.addListener('click', function() {
      infoWindow.open(map, marker);
    });

    // Reset to the center again after closing the info window
    google.maps.event.addListener(infoWindow, 'closeclick', function(){
      map.setCenter(latlngbounds.getCenter());
      map.fitBounds(latlngbounds);
    });
  });

  $.each(latLngs, function(index, latlng) {
    latlngbounds.extend(latlng);
  });
  map.setCenter(latlngbounds.getCenter());
  map.fitBounds(latlngbounds);
}

function addMarker(resource, map) {
  var marker = new google.maps.Marker({
    position: resource.position,
    title: resource.name,
    map: map
  });
  return marker;
}

function addInfoWindow(resource) {

  var contentString = '<div id="content">'+
    '<h1>' + resource.name + '</h1>'+
    '<div id="bodyContent">'+
    '<p>'+
    resource.address +
    '</p>'+
    '<a href="' + resource.url + '">'+
    'View Resource</a>' +
    '</div>'+
    '</div>';

  var infoWindow = new google.maps.InfoWindow({
    content: contentString
  });
  return infoWindow;
}
