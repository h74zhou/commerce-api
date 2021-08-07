module Mutations
  class CheckoutCart < BaseMutation

    type Types::CartType
    
    def resolve
      unless context[:current_user] 
        raise GraphQL::ExecutionError, "You need to sign to checkout your cart"
      end

      cart = Cart.find_by user: context[:current_user] 

      unless cart
        raise GraphQL::ExecutionError, "You need to create your cart first before you checkout"
      end

      # Validate the cart
      cart.cart_items.each do |id, quantity|
        # Check if each item/quantity still exists in inventory
        product = Product.find_by id: id

        unless product && quantity <= product.inventory_count
          raise GraphQL::ExecutionError, "Product: #{product.title} is no longer in stock at the current quantity you're requesting"
        end
      end

      # Checkout
      cart.cart_items.each do |id, quantity|
        product = Product.find_by id: id
        product.inventory_count -= quantity
        product.save!
      end

      cart.cart_items = {}
      cart.total_price = 0.0
      cart.save!

      return cart
    end
  end
end