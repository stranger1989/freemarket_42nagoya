class AddAncestryToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry

    remove_column :categories, :parent_id, :integer
  end
end
