module Types
  class CartType < Types::BaseObject
    field :user, Types::UserType, null: false
    field :total_price, Float, null: false
    field :cart_items, [Types::ProductType], null: false
  end
end
