class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_id).try(:name)
  end

  def prefecture_name=(prefecture)
    self.prefecture_id = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # 全てバリデーションのためのダミーデータ
  DEFAULT_USERPARAMS = {
     nickname: "testname",
     profile: "",
     avatar: "",
     lastname: "手簀戸手簀戸",
     firstname: "手簀戸手簀戸",
     lastname_kana: "テストテスト",
     firstname_kana: "テストテスト",
     postalcode: "000-0000",
     prefecture: "愛知県",
     city: "名古屋市",
     block: "テスト町",
     building: "テストビル",
     birthday: "1989-1-1",
     phone_number: "08000000000",
     payment: "aaaaaaa"
  }

  validates :nickname, presence: true, length: { maximum: 20 }
  validates :lastname, presence: true, length: { maximum: 20 }
  validates :firstname, presence: true, length: { maximum: 20 }
  validates :lastname_kana, presence: true, length: { maximum: 20 }
  validates :firstname_kana, presence: true, length: { maximum: 20 }
  validates :postalcode, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :block, presence: true
  validates :birthday, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A0[7-9]0-?\d{4}-?\d{4}\z/ }
  validates :payment, presence: true

  has_many :items
  has_many :orders
end
