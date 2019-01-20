class Item < ApplicationRecord

  validates :name, presence: true, length: {maximum: 40}
  validates :image, presence: true
  validates :description, presence: true, length: {maximum: 1000}
  validates :order_status, presence: true
  validates :item_status, presence: true
  validates :shipping_fee, presence: true
  validates :delivery_way, presence: true
  validates :shipping_area, presence: true
  validates :estimated_shipping_date, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

  mount_uploader :image, ImageUploader

  belongs_to :user

end
