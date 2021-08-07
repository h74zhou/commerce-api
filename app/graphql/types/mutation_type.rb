module Types
  class MutationType < Types::BaseObject
    field :create_product, mutation: Mutations::CreateProduct
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :signout_user, mutation: Mutations::SignOutUser
    field :create_cart, mutation: Mutations::CreateCart
    field :delete_cart, mutation: Mutations::DeleteCart
    field :add_product_to_cart, mutation: Mutations::AddProductToCart
    field :remove_product_from_cart, mutation: Mutations::RemoveProductFromCart
  end
end
