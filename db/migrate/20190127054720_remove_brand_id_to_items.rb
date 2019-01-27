class RemoveBrandIdToItems < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :items, :brands
    remove_index :items, :brand_id
    remove_reference :items, :brand
  end
end
