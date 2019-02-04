$(document).on('turbolinks:load', function() {
  $(function(){
    $('.bxslider').bxSlider({
      auto: true,
      speed: 1250,
      pause: 4000,
      moveSlides: 1,
      slideWidth: 1440,
      responsive: true,
      autoHover: true
    });
  });
});
