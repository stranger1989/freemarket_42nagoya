$(function() {
    if($("div").hasClass('alert-danger')){
      $(".alert-danger").siblings().children("input,select").css('border','1px solid red');
    }
});
