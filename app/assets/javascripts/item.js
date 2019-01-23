$(document).on('turbolinks:load',function() {
  // 販売手数料・販売利益の表示
  $(".price-form").on("keyup", function() {
    var price = $(this).val();

    if (price >= 300 && price < 10000000) {
      var commissions = Math.floor(price * 0.1);
      var profit = price - commissions;
      $(".commissions .l-right").text("¥" + commissions);
      $(".profit .l-right").text("¥" + profit);
    } else {
      $(".commissions .l-right").text("-");
      $(".profit .l-right").text("-");
    }
  })
});
