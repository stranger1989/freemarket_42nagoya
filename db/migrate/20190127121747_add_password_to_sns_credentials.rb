class AddPasswordToSnsCredentials < ActiveRecord::Migration[5.0]
  def change
    add_column :sns_credentials, :email, :string
    add_column :sns_credentials, :password, :string
  end
end
