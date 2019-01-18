require 'rails_helper'
describe User do
  describe '#create' do
    it "全ての項目が埋まっていればユーザー登録が可能" do
      user = build(:user)
      expect(user).to be_valid
    end
    it "ニックネームが入力されていないと登録できない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("入力してください")
    end
    it "ニックネームは20文字以内だと登録できる" do
      user = build(:user, nickname: "テスト0000000テスト0000000")
      user.valid?
      expect(user).to be_valid
    end
    it "ニックネームは21文字以上だと登録できない" do
      user = build(:user, nickname: "テスト0000000テスト00000001")
      user.valid?
      expect(user.errors[:nickname][0]).to include("20文字以内で入力してください")
    end
    it "Eメールが入力されていないと登録できない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("入力してください")
    end
    it "Eメールが2重で登録されていない" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("すでに存在します")
    end
    it "パスワードが入力されていないと登録できない" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("入力してください")
    end
    it "パスワードが存在してもパスワード確認が空では登録できないこと" do
      user = User.new(nickname: "sample", email: "kkk@gmail.com", password: "00000000", password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("入力が一致しません")
    end
    it "携帯電話が入力されていないと登録できない" do
      user = build(:user, phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("入力してください")
    end
    it "携帯電話の形式でないと登録できない" do
      user = build(:user, phone_number: "0000000000")
      user.valid?
      expect(user.errors[:phone_number]).to include("不正な値です")
    end
    it "携帯電話が2重で登録されていない" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:phone_number]).to include("すでに存在します")
    end
    it "名字が入力されていないと登録できない" do
      user = build(:user, lastname: nil)
      user.valid?
      expect(user.errors[:lastname]).to include("入力してください")
    end
    it "名字は20文字以内だと登録できる" do
      user = build(:user, lastname: "テスト0000000テスト0000000")
      user.valid?
      expect(user).to be_valid
    end
    it "名字は21文字以上だと登録できない" do
      user = build(:user, lastname: "テスト0000000テスト00000001")
      user.valid?
      expect(user.errors[:lastname][0]).to include("20文字以内で入力してください")
    end
    it "名前が入力されていないと登録できない" do
      user = build(:user, firstname: nil)
      user.valid?
      expect(user.errors[:firstname]).to include("入力してください")
    end
    it "名前は20文字以内だと登録できる" do
      user = build(:user, firstname: "テスト0000000テスト0000000")
      user.valid?
      expect(user).to be_valid
    end
    it "名前は21文字以上だと登録できない" do
      user = build(:user, firstname: "テスト0000000テスト00000001")
      user.valid?
      expect(user.errors[:firstname][0]).to include("20文字以内で入力してください")
    end
    it "名字カナが入力されていないと登録できない" do
      user = build(:user, lastname_kana: nil)
      user.valid?
      expect(user.errors[:lastname_kana]).to include("入力してください")
    end
    it "名字カナは20文字以内だと登録できる" do
      user = build(:user, lastname_kana: "テスト0000000テスト0000000")
      user.valid?
      expect(user).to be_valid
    end
    it "名字カナは21文字以上だと登録できない" do
      user = build(:user, lastname_kana: "テスト0000000テスト00000001")
      user.valid?
      expect(user.errors[:lastname_kana][0]).to include("20文字以内で入力してください")
    end
    it "名前カナが入力されていないと登録できない" do
      user = build(:user, firstname_kana: nil)
      user.valid?
      expect(user.errors[:firstname_kana]).to include("入力してください")
    end
    it "名前カナは20文字以内だと登録できる" do
      user = build(:user, firstname_kana: "テスト0000000テスト0000000")
      user.valid?
      expect(user).to be_valid
    end
    it "名前カナは21文字以上だと登録できない" do
      user = build(:user, firstname_kana: "テスト0000000テスト00000001")
      user.valid?
      expect(user.errors[:firstname_kana][0]).to include("20文字以内で入力してください")
    end
    it "郵便番号が入力されていないと登録できない" do
      user = build(:user, postalcode: nil)
      user.valid?
      expect(user.errors[:postalcode]).to include("入力してください")
    end
    it "郵便番号の形式があっていないと登録できない" do
      user = build(:user, postalcode: "00000000")
      user.valid?
      expect(user.errors[:postalcode]).to include("不正な値です")
    end
    it "都道府県が入力されていないと登録できない" do
      user = build(:user, prefecture: nil)
      user.valid?
      expect(user.errors[:prefecture]).to include("入力してください")
    end
    it "市区町村が入力されていないと登録できない" do
      user = build(:user, city: nil)
      user.valid?
      expect(user.errors[:city]).to include("入力してください")
    end
    it "番地が入力されていないと登録できない" do
      user = build(:user, block: nil)
      user.valid?
      expect(user.errors[:block]).to include("入力してください")
    end
    it "支払い方法が入力されていないと登録できない" do
      user = build(:user, payment: nil)
      user.valid?
      expect(user.errors[:payment]).to include("入力してください")
    end
  end
end
