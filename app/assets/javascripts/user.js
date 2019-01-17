$(function() {
    if($("div").hasClass('alert-danger')){
      console.log($(".alert-danger").siblings().html());
      $(".alert-danger").siblings().children("input,select").css('border','1px solid red');
    }
});
