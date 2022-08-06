defmodule SupermarketGraphQL.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  alias Supermarket.Repo

  # Configuration
  def context(context) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Repo, SupermarketGraphQL.Dataloader.data())

    Map.put(context, :loader, loader)
  end

  def plugins, do: [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()

  # Types
  import_types(Absinthe.Type.Custom)
  import_types(SupermarketGraphQL.Application.Types)
  import_types(SupermarketGraphQL.Cart.Types)
  import_types(SupermarketGraphQL.Cart.Item.Types)
  import_types(SupermarketGraphQL.Product.Types)
  import_types(SupermarketGraphQL.Product.Rule.Types)
  import_types(SupermarketGraphQL.General.Types)

  # Queries
  query do
    import_fields(:application_queries)
    import_fields(:cart_queries)
    import_fields(:product_queries)
  end

  # Mutations
  mutation do
    import_fields(:cart_mutations)
  end
end
