defmodule SupermarketGraphQL.Cart.Item.Types do
  @moduledoc """
  Cart Item Types
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias Supermarket.Repo

  #
  # Objects
  #

  object :cart_item do
    field(:id, non_null(:id))
    field(:quantity, non_null(:integer))
    field(:unit_price, non_null(:integer))
    field(:one_free, non_null(:boolean))

    field(:cart, non_null(:cart)) do
      resolve(dataloader(Repo))
    end

    field(:product, non_null(:product)) do
      resolve(dataloader(Repo))
    end

    field(:items, non_null(list_of(non_null(:cart_item)))) do
      resolve(dataloader(Repo))
    end

    import_fields(:timestamps)
  end
end
