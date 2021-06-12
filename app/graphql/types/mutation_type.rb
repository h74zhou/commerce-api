module Types
  class MutationType < Types::BaseObject
    field :create_product, mutation: Mutations::CreateProduct
  end
end
