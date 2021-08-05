module Mutations
  class DeleteCart < BaseMutation

    argument :user_id, ID, required: false

    field :deleted, Boolean, null: false

    def resolve(user_id: nil)
      delete_failed = {
        deleted: false,
      }

      return delete_failed unless user_id

      user = User.find_by id: user_id 

      return delete_failed unless user 

      cart = Cart.find_by user: user

      return delete_failed unless cart
      
      cart.destroy

      {
        deleted: true,
      }
    end
  end
end