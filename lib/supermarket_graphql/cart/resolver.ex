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

  def final_price(%{total_price: total_price}, _, _) when total_price in [nil, ""], do: {:ok, "-"}

  def final_price(%{total_price: total_price}, _, _) do
    {:ok, "£#{:erlang.float_to_binary(total_price / 100, decimals: 2)}"}
  end

  #
  # Mutations
  #

  def cart_create(_, %{basket: basket}, _), do: Carts.create(basket)

  def cart_complete(_, %{id: id}, _), do: Carts.complete(id)
end
