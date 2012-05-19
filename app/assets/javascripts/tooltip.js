$('.tooltip').hide();

$('.trigger').mouseover(function() {
  var ttLeft,ttTop,
    $this=$(this),
    $tip = $($this.attr('data-tooltip')); // end var

	triggerPos = $("#map").offset();	
	ttTop = triggerPos.top;
	ttLeft = triggerPos.left;

	$tip.css({
	   left : ttLeft ,
	   top : ttTop,
	   position: 'absolute'
	   }).fadeIn(200);
}); // end click

 $('.trigger').mouseout(function () {
     $('.tooltip').fadeOut(800);
 }); // end mouseout