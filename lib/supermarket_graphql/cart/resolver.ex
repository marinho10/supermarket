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

  #
  # Mutations
  #

  def cart_create(_, %{id: id}, _), do: {:ok, Carts.create(id)}

  def cart_complete(_, _, _), do: {:ok, Carts.complete(id)}
end
