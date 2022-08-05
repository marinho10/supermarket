defmodule SupermarketGraphQL.Cart.Types do
  @moduledoc """
  Cart Types
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias Supermarket.Cart
  alias Supermarket.Repo
  alias SupermarketGraphQL.Cart.Resolver

  #
  # Objects
  #

  object :cart do
    field(:id, non_null(:id))
    field(:code, non_null(:string))
    field(:status, non_null(:cart_status))
    field(:total_price, non_null(:integer))

    field(:items, non_null(list_of(non_null(:cart_item)))) do
      resolve(dataloader(Repo))
    end

    import_fields(:timestamps)
  end

  #
  # Enums
  #

  @desc "The cart status"
  enum(:cart_status, do: values(Cart.all_status()))

  #
  # Queries
  #

  object :cart_queries do
    @desc "
      Get an cart by `id`
    "
    field :cart, :cart do
      arg(:id, non_null(:id))

      resolve(&Resolver.cart/3)
    end

    @desc "
      List all carts
    "
    field :carts, non_null(list_of(non_null(:cart))) do
      resolve(&Resolver.carts/3)
    end
  end

  #
  # Mutations
  #

  object :cart_mutations do
    @desc "
      Create cart
    "
    field :cart_create, :cart do
      arg(:basket, non_null(:string))

      resolve(&Resolver.cart_create/3)
    end

    @desc "
      Complete cart and calculate final price
    "
    field :cart_complete, :cart do
      arg(:id, non_null(:id))

      resolve(&Resolver.cart_complete/3)
    end
  end
end
