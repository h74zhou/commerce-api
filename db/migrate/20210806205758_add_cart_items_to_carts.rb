class AddCartItemsToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :cart_items, :jsonb
  end
end
