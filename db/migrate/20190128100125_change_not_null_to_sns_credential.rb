class ChangeNotNullToSnsCredential < ActiveRecord::Migration[5.0]
  def up
    change_column :sns_credentials, :uid, :string, null: false
    change_column :sns_credentials, :provider, :string, null: false
  end

  def down
    change_column :sns_credentials, :uid, :string, null: true
    change_column :sns_credentials, :provider, :string, null: true
  end
end
