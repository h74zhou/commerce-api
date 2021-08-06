module Types
  class CartItemsType < Types::BaseObject
    field :id, ID, null: false
    field :quantity, Integer, null: false
  end
end