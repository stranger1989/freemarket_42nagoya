class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_id).try(:name)
  end

  def prefecture_name=(prefecture)
    self.prefecture_id = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  def self.find_for_oauth(auth)
    # 複数のsnsが使えるように別テーブルでsns情報を管理
    snscredential = SnsCredential.where(uid: auth.uid, provider: auth.provider).first

    unless snscredential
      snscredential = SnsCredential.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name:  auth.info.name,
        password: Devise.friendly_token[0, 20],
        token:    auth.credentials.token,
        image:  auth.info.image
      )
    end
    snscredential
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # 全てバリデーションのためのダミーデータ
  DEFAULT_USERPARAMS = {
     nickname: "testname",
     email: "test@yahoo.co.jp",
     password: "00000000",
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

  has_many :items
  has_many :orders
  has_many :sns_credentials
end
