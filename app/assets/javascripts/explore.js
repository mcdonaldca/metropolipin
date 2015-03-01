var latLng;

/*
	Render map based on initial and final location
*/
function initialize(lat, lng) {
	
	latLng = new google.maps.LatLng(lat, lng);
	var styles = [
	  {
	    "stylers": [
	      { "hue": "#3F5666" }
	    ]
	  }
	]
	var mapOptions = {
		zoom:7,
		center: latLng,
		styles: styles
	};
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	
	//var image = "img/" + type + ".png";
  	//var marker = new google.maps.Marker({ map: map, position: new google.maps.LatLng(latitude, longitude), icon: image });
}







