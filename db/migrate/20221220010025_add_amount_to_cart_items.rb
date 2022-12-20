class AddAmountToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :amount, :integer
  end
end
