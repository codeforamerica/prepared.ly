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

// tells Rails to accept js header so we don't have to add .js extension to every request
jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  $("#new_comment").submitWithAjax();
})

  var is_ssl = ("https:" == document.location.protocol);
  var asset_host = is_ssl ? "https://d3rdqalhjaisuu.cloudfront.net/" : "http://d3rdqalhjaisuu.cloudfront.net/";
  document.write(unescape("%3Cscript src='" + asset_host + "javascripts/feedback-v2.js' type='text/javascript'%3E%3C/script%3E"));
//-- feedback widget -->
  var is_ssl = ("https:" == document.location.protocol);
  var asset_host = is_ssl ? "https://d3rdqalhjaisuu.cloudfront.net/" : "http://d3rdqalhjaisuu.cloudfront.net/";
  document.write(unescape("%3Cscript src='" + asset_host + "javascripts/feedback-v2.js' type='text/javascript'%3E%3C/script%3E"));

  var feedback_widget_options = {};
    feedback_widget_options.display = "overlay";
    feedback_widget_options.company = "code_for_america";
    feedback_widget_options.placement = "right";
    feedback_widget_options.color = "#333333";
    feedback_widget_options.style = "question";
    feedback_widget_options.product = "code_for_america_preparedly";
    feedback_widget_options.tag = "feedback";
    feedback_widget_options.custom_css = "feedback.css";
    feedback_widget_options.limit = "3";
  var feedback_widget = new GSFN.feedback_widget(feedback_widget_options);
