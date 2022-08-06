defmodule Supermarket.Cart.Item.Query do
  @moduledoc """
  Cart item queries context.
  """

  import Ecto.Query, warn: false

  alias Supermarket.Cart.Item

  @doc """
  Base query for Cart items.
  """
  def base, do: Item |> from(as: :item)

  @doc """
  Filter by cart id
  """
  def filter_by_cart_id(query \\ base(), cart_id)
  def filter_by_cart_id(query, cart_id) when cart_id in [nil, ""], do: query

  def filter_by_cart_id(query, cart_id),
    do: query |> where([item: i], i.cart_id == ^cart_id)
end
