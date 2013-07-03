/* Toggle search field*/

$('.search-show').click(function() { 
  $('.search').addClass('focused'); 
  $('.search .input').focus();
});
$('.search input').focusout(function() { 
  setTimeout(function(){
    $('.search').removeClass('focused').addClass(text);
  },350);
});

/* Go to the next article on arrow down */
$('.next').on('click', function() { 
  var item = $('.current');

  item.removeClass('current');
  item.next().addClass('current'); 

  var pos = item.next().position().top - 60;
  
  $('html, body').animate({ scrollTop: pos }, 250);
});

/* Go to the prev article on arrow up */
$('.prev').on('click', function() { 
  var item = $('.current');

  item.removeClass('current');
  item.prev().addClass('current'); 

  var pos = item.prev().position().top - 60;
  
  $('html, body').animate({ scrollTop: pos }, 250);
});