class Category < ApplicationRecord
  has_many :items
  has_many :brands, through: :category_brands
  has_ancestry
end
