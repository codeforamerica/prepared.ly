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
//= require kiss







//add dashboard tab href to url in browser address bar
$('#sidenav a').click(function(e){
  // console.log("a link in the sidenav has been clicked on");
  e.stopPropagation();
  e.preventDefault();
  var href = $(this).attr('href');
  window.location = href;
  // console.log("href:");
  // console.log(href);
  // console.log("window.location:");
  // console.log(window.location);
});

$(document).ready(function(){
  // console.log("sidenav.length (expecting > 0): " + $("#sidenav").length);
  // console.log("window.location.hash (expecting empty): " + window.location.hash);
  // console.log($("#sidenav"));

  // By default, load #map-section in user dashboard
  if(($("#sidenav").length > 0) && (!window.location.hash)) {
    // console.log("sidenav.length is > 0 and window.location.hash is empty");
    window.location.hash = "#map-section";
  }
  // Handle permalinks to non-#map-section tabs in user dashboard
  else {
    // console.log("either sidenav.length was 0 or window.location.hash is true");
    var match = window.location.hash;
    $('#sidenav a[href="' + match + '"]').tab('show');
  };

  //use browser forward/back buttons to navigate dashboard tabs
  $(window).bind('hashchange', function(){
    var active_tab = window.location.hash;
    $('#sidenav a[href="' + active_tab + '"]').tab('show');
    $(window).scrollTop(0);
  });
  $(window).scrollTop(0);
});

$(window).on('load', function(){
  setTimeout(function() {
    $(window).scrollTop(0);
  }, 0);
});

// when <a> element in id sidenav is clicked, remove flash alert since page isn't refreshing
$("#sidenav a").click(function() {
  $('#notice').hide();
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

// alert to user if map search is empty, otherwise show ajax loading gif (disabled since it breaks things!)
$("#loadMap").click(function(){
            if($("#q").val() == '') {
                 alert("Please enter a street address with city and state; or zip code.");
                 $("#q").addClass('highlight');
                 return false;
            }; // else {
              //$('#mapinfo').html("<img src='assets/ajax-loader.gif'>");
            //}
        });
runonce = true;


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

// google analytics code moved to application.html.erb to ensure loading in head tag  
