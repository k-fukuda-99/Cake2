class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
       t.integer :customer_id
      t.integer :shipping_cost
      t.integer :total_payment
      t.integer :payment_method, default: 0
      t.integer :status, default: 0
      t.string :name
      t.string :postal_code
      t.string :address

      t.timestamps
    end
  end
end
