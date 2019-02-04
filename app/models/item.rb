class Item < ApplicationRecord

  validates :image, presence: { message: '画像がありません' }
  validates :name, presence: true, length: {maximum: 40, allow_blank: true, message: "40文字以下で入力してください"}
  validates :description, presence: true, length: {maximum: 1000, allow_blank:true, message: "1000文字以下で入力してください"}
  validates :order_status, presence: { message: '選択してください' }
  validates :item_status, presence: { message: '選択してください' }
  validates :shipping_fee, presence: { message: '選択してください' }
  validates :delivery_way, presence: { message: '選択してください' }
  validates :shipping_area, presence: { message: '選択してください' }
  validates :estimated_shipping_date, presence: { message: '選択してください' }
  validates :price, presence: {message: "300以上9999999以下で入力してください"}, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, allow_blank: true, message: "300以上9999999以下で入力してください"}

  validates :category_id, presence: { message: '選択してください' }

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :category

  has_one :order, dependent: :destroy

  enum size: { "XXS以下": "XXS以下", "XS(SS)": "XS(SS)", "S": "S", "M": "M", "L": "L", "XL(LL)": "XL(LL)", "2XL(3L)": "2XL(3L)", "3XL(4L)": "3XL(4L)", "4XL(5L)以上": "4XL(5L)以上", "FREE SIZE": "FREE SIZE"}

  enum item_status: {"新品、未使用": "新品、未使用", "未使用に近い": "未使用に近い", "目立った傷や汚れなし": "目立った傷や汚れなし", "やや傷や汚れあり": "やや傷や汚れあり", "傷や汚れあり": "傷や汚れあり", "全体的に状態が悪い": "全体的に状態が悪い"}

  enum shipping_fee: {"送料込み(出品者負担)": "送料込み(出品者負担)", "着払い(購入者負担)": "着払い(購入者負担)"}

  enum delivery_way: { "未定": "未定", "らくらくメルカリ便": "らくらくメルカリ便", "ゆうメール": "ゆうメール", "レターパック": "レターパック", "普通郵便(定形、定形外)": "普通郵便(定形、定形外)", "クロネコヤマト": "クロネコヤマト", "ゆうパック": "ゆうパック", "クリックポスト": "クリックポスト", "ゆうパケット": "ゆうパケット"}

  enum estimated_shipping_date: { "1〜2日で発送": "1〜2日で発送", "2〜3日で発送": "2〜3日で発送", "4〜7日で発送": "4〜7日で発送"}

end
