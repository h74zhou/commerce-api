module Types
  class CartType < Types::BaseObject
    field :user, Types::UserType, null: true
    field :total_price, Float, null: true
    field :items, [Types::CartItemsType], null: false
  
    def items
      cart = Cart.find_by user: context[:current_user]
      items_hash = cart.cart_items
      cart_items = []

      items_hash.each do |id, quantity|
        cart_items << Struct.new(:id, :quantity).new(id, quantity)
      end

      cart_items
    end
  end
end
