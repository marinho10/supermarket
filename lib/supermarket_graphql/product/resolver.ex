defmodule SupermarketGraphQL.Product.Resolver do
  @moduledoc """
  Product Resolver
  """

  alias Supermarket.Products

  #
  # Queries
  #

  def product(_, %{id: id}, _), do: {:ok, Products.get_by_id(id)}

  def products(_, _, _), do: {:ok, Products.list()}
end
