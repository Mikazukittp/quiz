$(function(){
	$(document).ready(function(){
		$(window).scroll(function(){
			if ($(this).scrollTop() > 540) {
				$('#header').fadeIn(600);
			} else {
				$('#header').fadeOut(600);
			}
		});
	});
});