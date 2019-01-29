FactoryGirl.define do

  factory :item do
    sequence(:id){ |n| }
    name                        { Faker::Vehicle.manufacture }
    image                       {Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test-image.png'), 'image/png')}
    description                 { Faker::Vehicle.manufacture }
    sequence(:order_status){ ['出品中','売却済'].sample }
    sequence(:item_status){ ["新品、未使用","未使用に近い","目立った傷や汚れなし","やや傷や汚れあり","傷や汚れあり","全体的に状態が悪い"].sample }
    sequence(:size){ ["XXS以下","XS(SS)","S","M","L","XL(LL)","2XL(3L)","3XL(4L)","4XL(5L)以上","FREE SIZE"].sample }
    sequence(:shipping_fee){ ["送料込み(出品者負担)","着払い(購入者負担)"].sample }
    sequence(:delivery_way){ ["未定","らくらくメルカリ便","ゆうメール","レターパック","普通郵便(定形、定形外)","クロネコヤマト","ゆうパック","クリックポスト","ゆうパケット"].sample }
    sequence(:shipping_area){ ["北海道","青森県","岩手県","宮城県"].sample }
    sequence(:estimated_shipping_date){ ["1〜2日で発送","2〜3日で発送","4〜7日で発送"].sample }
    sequence(:price){ [*300..10000].sample }
    association :user, factory: :user
    category
    created_at                  { Faker::Time.between(2.days.ago, Time.now, :all) }
    updated_at                  { Faker::Time.between(2.days.ago, Time.now, :all) }
  end

end
