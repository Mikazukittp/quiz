function goToByScroll(id){
  // Reove "link" from the ID
  id = id.replace("Link", "");
  
  // Scroll
  $('html,body').animate({scrollTop: $("#"+id).offset().top-40}, 800, 'easeInOutQuart');
}

$("ul > li > a").click(function(e){
  // Prevent a page reload when a link is pressed
  e.preventDefault();
  // Call the scroll function
  goToByScroll($(this).attr("class"));
});

$("#topButton").click(function(e){
  // Prevent a page reload when a link is pressed
  e.preventDefault();
  // Call the scroll function
  $('html,body').animate({scrollTop: 0}, 800, 'easeInOutQuart');
  goToByScroll($(this).attr("class"));
});
