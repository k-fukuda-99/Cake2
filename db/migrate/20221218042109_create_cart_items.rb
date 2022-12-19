class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price_excluding_tax, null: false
      t.string :image_id
      t.integer :genre_id, null: false
      t.boolean :sales_status, default: true, null: false

      t.timestamps
    end
  end
end
