require 'rails_helper'
describe Item do

  describe '#create' do
    it "全ての必須項目が入力されていれば出品できる" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "商品名が入力されていないと出品できない" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("入力してください")
    end

    it "商品名が40文字以内なら出品できる" do
      item = build(:item, name: "a" * 40)
      item.valid?
      expect(item).to be_valid
    end

    it "商品名が41文字以上だと出品できない" do
      item = build(:item, name: "a" * 41)
      item.valid?
      expect(item.errors[:name]).to include("40文字以下で入力してください")
    end

    it "画像が空だと出品できない" do
      item = build(:item, image: nil)
      item.valid?
      expect(item.errors[:image]).to include("画像がありません")
    end

    it "商品の説明が入力されていないと出品できない" do
      item = build(:item, description: nil)
      item.valid?
      expect(item.errors[:description]).to include("入力してください")
    end

    it "商品の説明が1000文字以内なら出品できる" do
      item = build(:item, description: "a" * 1000)
      item.valid?
      expect(item).to be_valid
    end

    it "商品の説明が1001文字以上だと出品できない" do
      item = build(:item, description: "a" * 1001)
      item.valid?
      expect(item.errors[:description]).to include("1000文字以下で入力してください")
    end

    it "商品の状態が選択されていないと出品できない" do
      item = build(:item, item_status: nil)
      item.valid?
      expect(item.errors[:item_status]).to include("選択してください")
    end

    it "サイズが選択されていないと出品できない" do
      item = build(:item, size: nil)
      item.valid?
      expect(item.errors[:size]).to include("選択してください")
    end

    it "配送料の負担が選択されていないと出品できない" do
      item = build(:item, shipping_fee: nil)
      item.valid?
      expect(item.errors[:shipping_fee]).to include("選択してください")
    end

    it "配送の方法が選択されていないと出品できない" do
      item = build(:item, delivery_way: nil)
      item.valid?
      expect(item.errors[:delivery_way]).to include("選択してください")
    end

    it "発送元の地域が選択されていないと出品できない" do
      item = build(:item, shipping_area: nil)
      item.valid?
      expect(item.errors[:shipping_area]).to include("選択してください")
    end

    it "発送までの日数が選択されていないと出品できない" do
      item = build(:item, estimated_shipping_date: nil)
      item.valid?
      expect(item.errors[:estimated_shipping_date]).to include("選択してください")
    end

    it "価格が入力されていなければ出品できない" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("300以上9999999以下で入力してください")
    end

    it "入力された価格が数字以外の場合は出品できない" do
      item = build(:item, price: "三百")
      item.valid?
      expect(item.errors[:price]).to include("300以上9999999以下で入力してください")
    end

    it "入力された価格が300未満の場合は出品できない" do
      item = build(:item, price: 299)
      item.valid?
      expect(item.errors[:price]).to include("300以上9999999以下で入力してください")
    end

    it "入力された価格が10,000,000以上の場合は出品できない" do
      item = build(:item, price: 10000000)
      item.valid?
      expect(item.errors[:price]).to include("300以上9999999以下で入力してください")
    end

    it "入力された価格が300以上9,999,999以下であれば出品できる" do
      item = build(:item, price: 3000)
      item.valid?
      expect(item).to be_valid
    end

  end

end
