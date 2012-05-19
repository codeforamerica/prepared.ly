$('.tooltip').hide();

$('.trigger').click(function() {
  var ttLeft,
    ttTop,
    $this=$(this),
    $tip = $($this.attr('data-tooltip')),
    triggerPos = $this.offset(),
     triggerH = $this.outerHeight(),
     triggerW = $this.outerWidth(),
     tipW = $tip.outerWidth(),
     tipH = $tip.outerHeight(),
     scrollTop = $(document).scrollTop(); // end var
		
		ttTop = triggerPos.left;
		ttLeft = triggerPos.right;

	 $tip.css({
	     left : ttLeft ,
	     top : ttTop,
	     position: 'absolute'
	     }).fadeIn(200);
}); // end click

 // $('.trigger').mouseout(function () {
 //     $('.tooltip').fadeOut(200);
 // }); // end mouseout