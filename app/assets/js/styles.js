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

});

$(document).scroll(function() {
  var scrollTop = $(document).scrollTop();
  
  $('.controls').removeClass('fixed');
  $('.side').removeClass('fixed');

  if (scrollTop > 40) {
    $('.controls').addClass('fixed');
    $('.side').addClass('fixed');
  }
});

