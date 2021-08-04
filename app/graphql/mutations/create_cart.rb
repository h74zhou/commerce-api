module Mutations
  class CreateCart < BaseMutation
    argument :user_id, ID, required: false

    type Types::CartType

    def resolve(user_id: nil)
      unless context[:current_user] 
        raise GraphQL::ExecutionError, "You need to sign in to create a Cart"
      end

      Cart.create!(
        user: context[:current_user]
      )
    end
  end
end