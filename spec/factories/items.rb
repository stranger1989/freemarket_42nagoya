FactoryGirl.define do

  factory :item do
    id                          "1"
    name                        "itemname"
    image                       {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test-image.png'), 'image/png')}
    description                 "テストです"
    order_status                "出品中"
    item_status                 "新品、未使用"
    size                        "M"
    shipping_fee                "送料込み(出品者負担)"
    delivery_way                "未定"
    shipping_area               "北海道"
    estimated_shipping_date     "1〜2日で発送"
    price                       "300"
    user
    category
    brand
    created_at                  "2019-01-21T00:00:00Z"
    updated_at                  "2019-01-21T00:00:00Z"
  end

end
