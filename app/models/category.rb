class Category < ApplicationRecord
  has_many :items
  has_many :brands
  has_ancestry
end
