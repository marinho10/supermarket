defmodule SupermarketGraphQL.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  alias Supermarket.Repo

  import_types(Absinthe.Type.Custom)
  import_types(SupermarketGraphQL.Application.Types)

  query do
    import_fields(:application_queries)
  end

  # Even if having an empty mutation block is valid and works in Ansinthe, it
  # causes a Javascript error in GraphiQL so uncomment it when you add the
  # first mutation.
  #
  # mutation do
  # end

  def context(context) do
    Map.put(context, :loader, Dataloader.add_source(Dataloader.new(), Repo, Dataloader.Ecto.new(Repo)))
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
