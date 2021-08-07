module Mutations
  class CreateCart < BaseMutation

    type Types::CartType

    def resolve
      unless context[:current_user] 
        raise GraphQL::ExecutionError, "You need to sign in to create a Cart"
      end

      cart = Cart.find_by user: context[:current_user]

      return unless !cart

      Cart.create!(
        user: context[:current_user],
        total_price: 0.0,
        cart_items: {},
      )
    end
  end
end