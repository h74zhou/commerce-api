module Mutations
  class CreateProduct < BaseMutation
    # arguments passed to the `resolve` method
    argument :title, String, required: true
    argument :price, Float, required: true
    argument :inventory_count, Integer, required: true

    # return type from the mutation
    type Types::ProductType

    def resolve(title: nil, price: nil, inventory_count: nil)
      Product.create!(
        title: title,
        price: price,
        inventory_count: inventory_count
      )
    end
  end
end