module Mutations
  class CreateCart < BaseMutation
    argument :user_id, ID, required: false

    type Types::CartType

    # def resolve(user_id: nil)
    #   Vote.create!(
    #     user: context[:current_user]
    #   )
    # end
  end
end