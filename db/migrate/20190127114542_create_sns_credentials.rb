class CreateSnsCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :sns_credentials do |t|
      t.string :uid
      t.string :provider
      t.string :name
      t.string :image
      t.string :token
      t.references :user,                   foreign_key: true
      t.timestamps
    end
  end
end
