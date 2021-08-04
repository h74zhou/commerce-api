module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    field :all_products, [ProductType], null: false

    def all_products
      Product.all
    end

    field :all_users, [UserType], null: false

    def all_users
      User.all
    end
  end
end