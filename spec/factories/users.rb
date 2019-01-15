FactoryGirl.define do

  factory :user do
    nickname              "testname"
    email                 "test@gmail.com"
    password              "00000000"
    password_confirmation "00000000"
    lastname              "testlastname"
    firstname             "testfirstname"
    lastname_kana         "testlastname_kana"
    firstname_kana        "testfirstname_kana"
    postalcode            "000-0000"
    prefecture            "愛知県"
    city                  "名古屋市"
    block                 "テスト町"
    building              "テストビル"
    birthday              "1980-1-1"
    phone_number          "080-1234-5678"
    payment               "カード払い"
  end

end
