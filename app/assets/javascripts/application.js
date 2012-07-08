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
    $('#sidenav a[href="#map-section"]').tab('show');
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

// map creation and update stuff moved into map/_mapinfo partial