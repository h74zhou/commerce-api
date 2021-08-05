module Types
  class MutationType < Types::BaseObject
    field :create_product, mutation: Mutations::CreateProduct
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :signout_user, mutation: Mutations::SignOutUser
    field :create_cart, mutation: Mutations::CreateCart
    field :delete_cart, mutation: Mutations::DeleteCart
  end
end
