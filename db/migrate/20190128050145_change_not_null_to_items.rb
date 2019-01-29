class ChangeNotNullToItems < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :size, :string, null: true
  end
end
