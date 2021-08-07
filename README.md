# Commerce API

Welcome to my Commerce API project. This is a backend Graph API that provides the functionalities of an e-commerce service. Users can create products, set their price and upload inventory information. They can also create an account, login, browse store items, add them to a shopping cart and then checkout their purchase! There are mechanisms in place which align the database with each shopping cart, so users will never mistakenly purchase an item that is not in stock. Note that this API covers only the backend. Feel free to fork this repo and connect a custom online shopping UI!

## Project Outline

The product schema for this project insists upon 3 fields: `title`, `price` and `inventoryCount`. The ID generated will be using the standard Ruby on Rails `ID` type. 

```Ruby
module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :price, Float, null: false
    field :inventory_count, Integer, null: false
  end
end
```

### Adding and Searching for Products

Since this project was built with GraphQL, you will be using mutations to make changes to the database. The `createProduct` mutation can be used to do this. The following GraphQL mutation adds a new product called "earphones", with a price of `20.15` and an inventory stock of `3`. 

```GraphQL
mutation {
  createProduct(title: "Earphones", price: 20.15, inventoryCount: 3) {
    title
    price
    inventoryCount
  }
}
```

To see all available products in the database, you can use the `allProducts` query.

```GraphQL
{
  allProducts {
    id
    title
    price
    inventoryCount
  }
}
```

A sample return object for your inventory is:

```GraphQL
{
  "data": {
    "allProducts": [
      {
        "id": "1",
        "title": "Rubix Cube",
        "price": 3.99,
        "inventoryCount": 1
      },
      {
        "id": "2",
        "title": "ToothBrush",
        "price": 10.5,
        "inventoryCount": 6
      },
      {
        "id": "3",
        "title": "Earphones",
        "price": 20.15,
        "inventoryCount": 3
      }
    ]
  }
}
```

### Creating a User and Signing In

In order to make purchases, you first need to create an account. This can be done with the `CreateUser` mutation. You will need to provide a name, email and password:

```GraphQL
mutation {
 createUser(
  name: "Elon"
  authProvider: {
    credentials: {
      email: "elon@gmail.com",
      password: "123"
    }
  }
 ) {
    id
    email
    name
 }
}
```

After creating your user, you may use the `SignInUser` mutation to login to your account by providing your credentials. The mutation will return a `token` which will be used to validate your web session. Any authenticated request (i.e. Adding to Cart, Checking Out, etc) will require this token in its header to verify the request.

```GraphQL
mutation {
  signinUser(
    credentials: {
      email: "elon@gmail.com"
      password: "123"
    }
  ) {
    token
    user {
      id
      name
    }
  }
}
```

### Creating a Cart and Checking Out

Once you've signed in and successfully received a token, you can then use the `CreateCart` mutation to add items to your cart. As you can see, there's no argument to this query because the backend reads the header of your request to retrieve the `token` for verifying your user. As long as you're signed in, you'll be able to create a new cart!

```GraphQL
mutation {
  createCart {
    user {
      id
      name
    }
    totalPrice
    items {
      quantity
      id
    }
  }
}
```

Finally, once you're ready to checkout, you can run the `CheckoutCart` mutation. This will take all the items in your cart and remove the quantities you're purchasing from the `inventory_count` for each `Product`. Note that GraphQL exceptions will be thrown if you attempt to purchase items that exceed the current available stock. 

```GraphQL
mutation {
  checkoutCart {
    items {
      quantity
      id
    }
    totalPrice
    user {
      name
      id
    }
  }
}
```

There are other queries and mutations that have been created to flush out the functionality of this e-commerce backend. They include:

| Queries/Mutations | Arguments | Description |
| ------------------| :-------: | ------------|
| `allUsers`        | N/A       | Queries for all users that have been created |
| `allCarts`        | N/A       | Queries for all carts that have been created |
| `deleteCart`      | N/A       | Deletes the cart for the current logged in user |
| `removeProductFromCart` | `productId`, `quantity` | Removes a product from the logged in user's cart based on the specified `quantity` |
| `signoutUser`     | N/A       | Signs out the current user | 


## Tech Stack

This project was built using [Ruby on Rails](https://rubyonrails.org/) and [GraphQL](https://graphql.org/). The API utilizes the built-in Ruby on Rails [SQLite3](https://www.sqlite.org/index.html) database to store all the information provided by the user. The authentication was implemented with [Rails Sessionization](https://guides.rubyonrails.org/security.html#what-are-sessions-questionmark) which relies on the [bcrypt gem](https://github.com/bcrypt-ruby/bcrypt-ruby) to encrypt user passwords.
