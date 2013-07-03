$(document).ready(function() {
  $('.add').on('click', function() {
    $('.addMore').toggleClass('expanded');
    $('.add').toggle();
  }); 

  $('.options li span').click(function() {
    $('.options li span').removeClass('active');
    $(this).addClass('active');
  }); 

  $('.options li span.full').click(function() {
    $('main').removeClass('condensed');
  }); 

  $('.options li span.condensed').on('click', function() {
    $('main').addClass('condensed');
  }); 

  $('main section').click(function() {
    $(this).toggleClass('expanded');
  });

  $('body').addClass('ready');
});


var docEl = $(document);

docEl.on('scroll', function() { 

  var scrollTop = docEl.scrollTop();

  /* stick controls to the top */
  $('.controls').removeClass('fixed');
  $('.side').removeClass('fixed');

  if (scrollTop > 40) {
    $('.controls').addClass('fixed');
    $('.side').addClass('fixed');
  }

  /* mark visible article as current */
  var item = $('.current');
  
  var height = item.height();

  var position = item.position();
  var positionTop = position.top;
  var positionLeft = position.left;
  var positionBottom = position.top + height;

  var resUp   = positionBottom - scrollTop;
  var resDown = positionTop - scrollTop;

  item.addClass("current");

  if (resDown > 60 ) {
    if (!item.hasClass("first")) {
      item.removeClass('current');
      item.prev().addClass('current');
    } 
  } 

  if (resUp < 60) {
    item.removeClass('current');
    item.next().addClass('current');  
  }
});

/* Go to the next article on arrow down */
docEl.keydown(function(e){
  if (e.keyCode == 40) { 

    var item = $('.current');

    item.removeClass('current');
    item.next().addClass('current'); 

    var pos = item.next().position().top - 60;
    
    $('html, body').animate({ scrollTop: pos }, 250);

    return false;
  }
  if (e.keyCode == 38) { 

    var item = $('.current');

    item.removeClass('current');
    item.prev().addClass('current'); 

    var pos = item.prev().position().top - 60;
    
    $('html, body').animate({ scrollTop: pos }, 250);

    return false;
  }
});
