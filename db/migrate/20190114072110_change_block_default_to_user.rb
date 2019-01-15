class ChangeBlockDefaultToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :block, :string, default: ""
  end
end
