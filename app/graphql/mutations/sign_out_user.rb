module Mutations
  class SignOutUser < BaseMutation
    null true

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve
      # basic validation
      token = context[:session][:token]
      user = context[:current_user]

      context[:session][:token] = nil

      { user: user, token: token }
    end
  end
end