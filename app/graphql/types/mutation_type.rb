module Types
  class MutationType < Types::BaseObject
    field :create_product, mutation: Mutations::CreateProduct
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
  end
end
