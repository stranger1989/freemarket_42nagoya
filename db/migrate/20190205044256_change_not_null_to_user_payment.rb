class ChangeNotNullToUserPayment < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :payment, :string, null: true
  end
end
