module Mutations
  class AddProductToCart < BaseMutation
    argument :product_id, ID, required: true
    argument :user_id, ID, required: true

    type Types::CartType

    def resolve(product_id: nil, user_id: nil)
      user = User.find_by id: user_id

      cart = Cart.find_by user: user
      product = Product.find_by id: product_id

      unless cart
        raise GraphQL::ExecutionError, "You must create a cart before you can add products"
      end

      unless product
        raise GraphQL::ExecutionError, "The product you're trying to add no longer exists in the inventory"
      end
    
      cart.cart_items << product
      cart.total_price += product[:price]

      {
        cart: cart
      }
    end
  end
end