module Mutations
  class AddProductToCart < BaseMutation
    argument :product_id, ID, required: true
    argument :quantity, Integer, required: true

    type Types::CartType

    def resolve(product_id: nil, quantity: nil)
      unless context[:current_user] 
        raise GraphQL::ExecutionError, "You need to sign in to add to your cart"
      end

      unless quantity
        raise GraphQL::ExecutionError, "You need to select a quantity for the item you want to buy"
      end

      user = context[:current_user] 

      cart = Cart.find_by user: user
      product = Product.find_by id: product_id

      unless cart
        raise GraphQL::ExecutionError, "You must create a cart before you can add products"
      end

      unless product
        raise GraphQL::ExecutionError, "The product you're trying to add no longer exists in the inventory"
      end

      if cart.cart_items[product_id]
        cart.cart_items[product_id] += quantity
      else
        cart.cart_items[product_id] = quantity
      end

      new_total_price = 0.0
      cart.cart_items.each do |id, quantity|
        current_product = Product.find_by id: id
        new_total_price += current_product.price * quantity
      end

      cart.total_price = new_total_price
      cart.save!

      return cart
    end
  end
end