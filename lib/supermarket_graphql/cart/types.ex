defmodule SupermarketGraphQL.Cart.Types do
  @moduledoc """
  Cart Types
  """
  use Absinthe.Schema.Notation

  alias Supermarket.Cart
  alias SupermarketGraphQL.Cart.Resolver

  #
  # Objects
  #

  object :cart do
    field(:id, non_null(:id))
    field(:code, non_null(:string))
    field(:status, non_null(:cart_status))
    field(:total_price, non_null(:integer))

    import_fields(:timestamps)
  end

  #
  # Enums
  #

  @desc "The cart status"
  enum(:cart_status, do: values(Cart.all_status()))

  #
  # Query
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
end
