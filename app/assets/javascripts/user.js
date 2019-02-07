$(document).on('turbolinks:load',function() {
  if ($("div").hasClass('alert-danger')) {
    $(".alert-danger").siblings().children("input,select").css('border','1px solid red');
  }

  // お知らせ・やることリストのタブ切り替え
  // hrefの最初に"#panel"がつくaタグのクリック設定
  $('.mypage-tabs a[href^="#panel"]').click(function() {
    $(".tab-content .panel").hide();
    // クリックしたaタグからアンカー名を取得
    $(this.hash).show();
    // activeクラスを削除
    $('.mypage-tabs a').removeClass('active');
    // クリックしたタブにactiveクラスを付与
    $(this).addClass('active');
    // onclick="return false"と同様にデフォルトのクリックイベントを中断
    return false;
  });
  // お知らせを最初から表示
  $('.mypage-tabs a[href^="#panel"]:eq(0)').trigger('click');

  // 取引中・過去の取引のタブ切り替え
  $('.item-info-tabs a[href^="#panel"]').click(function() {
    $(".item-info-tab-content .panel").hide();
    $(this.hash).show();
    $('.item-info-tabs a').removeClass('active');
    $(this).addClass('active');
    return false;
  });
  // 取引中を最初から表示
  $('.item-info-tabs a[href^="#panel"]:eq(0)').trigger('click');


  // サイドバーの現在地にCSSを当てる
  var url = window.location.pathname;
  $('.side-nav__list > li > a[href="'+url+'"]').addClass('location');

  // ユーザー登録プログレスバーに現在の位置を当てる
  var registration_url = window.location.pathname;
  var registration_dir = registration_url.split("/")
  var registration_pathname = registration_dir[registration_dir.length-1]
  $(`.progress-bar > ${ "." + registration_pathname + "_point"}`).addClass('is-active');
  $(`.progress-bar > ${ "." + registration_pathname + "_point"}`).prevAll().addClass('prev-active');
});

