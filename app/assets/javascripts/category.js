
// カテゴリ選択フォームの動的生成
$(document).on('turbolinks:load', function() {

// 大カテゴリが選択された時
  $('.root_category').change(function(event, template) {
    var val = $('.root_category').val();
      var template = $(`#child_of${val}`);
      $(this).nextAll().remove();
      $(this).parent().append(template.html());
  });

// 中カテゴリが選択された時
  $(document).on('change', '.child_categories', function(event, template) {
    var val = $('.child_categories').val();
    var template = $(`#child_of${val}`);
    $(this).nextAll().remove();
    $(this).parent().append(template.html());
  });

});


