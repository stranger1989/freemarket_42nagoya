class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name,                       null:false
      t.text :image
      t.integer :price,                     null:false
      t.string :order_status,               null:false
      t.string :imem_status,                null:false
      t.string :shipping_fee,               null:false
      t.string :delivery_way,               null:false
      t.string :shipping_area,              null:false
      t.datetime :estimated_shipping_date,  null:false
      t.text :description,                  null:false
      t.string :size
      t.references :user,                   foreign_key: true

      t.timestamps
    end
    add_index :items, :name
  end
end
