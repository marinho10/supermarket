defmodule SupermarketGraphQL.Product.Types do
  @moduledoc """
  Product Types
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias Supermarket.Repo
  alias SupermarketGraphQL.Product.Resolver

  #
  # Objects
  #

  object :product do
    field(:id, non_null(:id))
    field(:code, non_null(:string))
    field(:name, non_null(:string))
    field(:price, non_null(:integer))

    field(:rules, non_null(list_of(non_null(:product_rule)))) do
      resolve(dataloader(Repo))
    end

    import_fields(:timestamps)
  end

  #
  # Queries
  #

  object :product_queries do
    @desc "
      Get an product by `id`
    "
    field :product, :product do
      arg(:id, non_null(:id))

      resolve(&Resolver.product/3)
    end

    @desc "
      List all products
    "
    field :products, non_null(list_of(non_null(:product))) do
      resolve(&Resolver.products/3)
    end
  end
end
