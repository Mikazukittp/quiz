$(function() {
	$("#makeQuizButton").click(function() {
		$(".coverAll").fadeIn();
		$("#modal").fadeIn();
	});

	$(".coverAll").click(function(){
		$(".coverAll").fadeOut();
		$("#modal").fadeOut();
	});
});