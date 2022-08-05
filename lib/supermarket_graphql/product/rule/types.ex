defmodule SupermarketGraphQL.Product.Rule.Types do
  @moduledoc """
  Product Rule Types
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias Supermarket.Repo

  #
  # Objects
  #

  object :product_rule do
    field(:id, non_null(:id))
    field(:expression, non_null(:string))

    field(:product, non_null(:product)) do
      resolve(dataloader(Repo))
    end

    import_fields(:timestamps)
  end
end
