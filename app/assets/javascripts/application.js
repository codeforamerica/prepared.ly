// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap-transition
//= require bootstrap-alert
//= require bootstrap-modal
//= require bootstrap-dropdown
//= require bootstrap-scrollspy
//= require bootstrap-tab
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-button
//= require bootstrap-collapse
//= require bootstrap-carousel
//= require bootstrap-typeahead
//= require timepicker

// load map-section in dashboard by default on page load
$(document).ready(function(){
    $('#joe a[href="#map-section"]').tab('show');
});


$(document).ready(function(){
  $("#pick_date").datetimepicker({
  	dateFormat: 'yy-mm-dd ',
  	timeFormat: 'hh:mm:ss tt',
  	showMinute: false,
		stepHour: 1,
  	ampm: true
  });;
});

var map;
var homeMarker;
$(document).ready(function() {

function setupMap() {

	// make a map, using normal leaflet and stamen toner tiles
	map = new L.Map('map', {maxZoom: 18});
	var mapCenter = new L.LatLng(address_location.lat, address_location.lon);
	var mapZoom = 12;
	var baseUrl = 'http://{s}.tile.stamen.com/terrain/{z}/{x}/{y}.jpg',
	    attrib = 'Map tiles by Stamen',
	    baseLayer = new L.TileLayer(baseUrl, {attribution: attrib, maxZoom:18});
	map.addLayer(baseLayer);


	var fireUrl = 'http://radarcache.srh.noaa.gov/tilecache/tilecache.py/1.0.0/fwx/{z}/{x}/{y}.png?type=google&LAYERS=fwx', attrib = 'Red flag fire warning from NWS', fireLayer = new L.TileLayer(fireUrl, {attribution: attrib, maxZoom:18}); 
	map.addLayer(fireLayer);


	var tx_burn_ban_counties = new L.CartoDBLayer({
	show_cartodb_logo: false,
	map_canvas: 'map',
	map: map,
	user_name:'tinio',
	table_name: 'cntys04',
	query: "SELECT cartodb_id, the_geom_webmercator FROM {{table_name}} WHERE name in ("+county_list+")",
	infowindow: "SELECT cartodb_id, name_locas FROM {{table_name}} WHERE cartodb_id={{feature}}",
	auto_bound: false 
	});

	homeMarker = new L.Marker(new L.LatLng(address_location.lat, address_location.lon));
	map.addLayer(homeMarker);
	map.setView(mapCenter, mapZoom);


	var MyIcon = L.Icon.extend({
	    iconUrl: '/assets/firestation.png',
	    shadowUrl: '',
	    iconSize: new L.Point(40, 13),
	    shadowSize: new L.Point(0, 0),
	    iconAnchor: new L.Point(20, 13),
	    popupAnchor: new L.Point(-3, -26)
	});

	var icon = new MyIcon();

	

	var stations = new L.LayerGroup();
	for(f in fire_stations){
	    station = fire_stations[f];
	    
	    var m = new L.Marker(new L.LatLng(station.latlon.coordinates[1], station.latlon.coordinates[0]), {icon:icon});
	    stations.addLayer(m);
	    m.bindPopup(station.address + "<br />Austin, TX " + station.zip).openPopup();
	}
	map.addLayer(stations);

	$('#firestations').click(function(){
	    if($(this).is(":checked")){
	         map.addLayer(stations);
	    }else{
	        map.removeLayer(stations);
	    }
	})
}
function updateMap(data){

	var mapCenter = new L.LatLng(data.location.lat, data.location.lon);
	map.setView(mapCenter, 12);
	map.removeLayer(homeMarker)	
	homeMarker = new L.Marker(mapCenter);
	map.addLayer(homeMarker);

	//set details
	$("#risk-text").text(data.risk_text);
	$("#risk-text").removeClass(function(){ var classes="";for(i in [0,1,2,3,4,5,6,7,8,9]){classes+="risk-"+i+" ";} return classes; })
		.addClass("risk-"+data.risk_level);	
	$("#wind-conditions").text(data.wind_conditions);
	$("#relative-humidity").text(data.relative_humidity);
	$("#relative-humidity").text(data.relative_humidity);
	$("#inside-burnban").text(data.inside_burnban);
	$("#inside-nws").text(data.inside_nws);
	$("#address").text(data.address)
}


if($("#mapinfo").length > 0){

	setupMap();
	$("#fetchaddress").submit(function(e){
		e.preventDefault();

		$.ajax("/mapinfo", {data:{q:$(this).find("input#q").val()},success:function(data){
			updateMap(data);
		}})
	});
	$("#fetchaddress").submit();

}
});	


