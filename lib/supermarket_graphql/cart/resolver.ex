defmodule SupermarketGraphQL.Cart.Resolver do
  @moduledoc """
  Cart Resolver
  """

  alias Supermarket.Carts

  #
  # Queries
  #

  def cart(_, %{id: id}, _), do: {:ok, Carts.get_by_id(id)}

  def carts(_, _, _), do: {:ok, Carts.list()}
end
