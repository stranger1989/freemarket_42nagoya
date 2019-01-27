class RemoveCategoryIdIdFromItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :category_id_id
  end
end
