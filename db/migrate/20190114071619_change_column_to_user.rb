class ChangeColumnToUser < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :block, :string, null: false
  end
  def down
    change_column :users, :block, :string, null: true
  end
end
