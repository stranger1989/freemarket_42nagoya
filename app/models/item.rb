class Item < ApplicationRecord

  validates :image, presence: { message: '画像がありません' }
  validates :name, presence: true, length: {maximum: 40, allow_blank: true, message: "40文字以下で入力してください"}
  validates :description, presence: true, length: {maximum: 1000, allow_blank:true, message: "1000文字以下で入力してください"}
  validates :order_status, presence: { message: '選択してください' }
  validates :item_status, presence: { message: '選択してください' }
  validates :size, presence: { message: '選択してください' }
  validates :shipping_fee, presence: { message: '選択してください' }
  validates :delivery_way, presence: { message: '選択してください' }
  validates :shipping_area, presence: { message: '選択してください' }
  validates :estimated_shipping_date, presence: { message: '選択してください' }
  validates :price, presence: {message: "300以上9999999以下で入力してください"}, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, allow_blank: true, message: "300以上9999999以下で入力してください"}

  validates :category_id, presence: { message: '選択してください' }

  mount_uploader :image, ImageUploader

  belongs_to :user
  belongs_to :brand
  belongs_to :category

end
