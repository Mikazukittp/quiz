$(function(){
	$(document).ready(function(){
		$(window).scroll(function(){
			if ($(this).scrollTop() > 550) {
				$('header').show();
				$('#topButton').show("slide", {direction:"down"}, 500);
			} else {
				$('header').hide();
				$('#topButton').slideUp();
			}
		});
	});
});