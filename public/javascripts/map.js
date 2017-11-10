var map;

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
		center: {
			lat: 48.873,
			lng: 2.358
		},
		zoom:11
	});
}


function initMap(){
	var myMap = document.querySelector('map');


	$.get('/main/mapinit',function(locations){
		var map = new google.maps.Map(document.getElementById('map'), {
			zoom: 11,
			center: new google.maps.LatLng(48.873, 2.358),
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});

		var infowindow = new google.maps.InfoWindow({});

		console.log('adresses3 :', locations);


		var marker, i;

		for (i = 0; i < locations.length; i++) {
			marker = new google.maps.Marker({
				position: new google.maps.LatLng(locations[i].latitude, locations[i].longitude),
				map: map
			});
			console.log(locations[i]);

			google.maps.event.addListener(marker, 'click', (function (marker, i) {
				return function () {
					infowindow.setContent(locations[i].address);
					infowindow.open(map, marker);
				}
			})(marker, i));
		}
	});

}
