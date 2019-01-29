FactoryGirl.define do

  factory :sns_credential do
    uid              "00000000000000000"
    sequence(:provider){ ["facebook","google"].sample }
    name             { Faker::Name.name }
    image            "http://graph.facebook.com/v2.10/00000000000000/picture"
    token            "00000000000000000"
    association :user, factory: :user
    created_at                  { Faker::Time.between(2.days.ago, Time.now, :all) }
    updated_at                  { Faker::Time.between(2.days.ago, Time.now, :all) }
    email            { Faker::Internet.email }
    password         { Faker::Code.ean }
  end

end
