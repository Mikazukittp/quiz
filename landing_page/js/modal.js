$(function(){
	$("#registerLink").click(function() {
		$("#login").fadeOut();
		$("#register").fadeIn();
		$("#modal").animate({height:310});
	});

	$("#loginLink").click(function() {
		$("#register").fadeOut();
		$("#login").fadeIn();
		$("#modal").animate({height:255});
	});
});