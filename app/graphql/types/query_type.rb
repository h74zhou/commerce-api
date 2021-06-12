module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    field :all_products, [ProductType], null: false

    def all_products
      Product.all
    end
  end
end