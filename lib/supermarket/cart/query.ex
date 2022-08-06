defmodule Supermarket.Cart.Query do
  @moduledoc """
  Cart queries context.
  """

  import Ecto.Query, warn: false

  alias Supermarket.Cart

  @doc """
  Base query for Carts.
  """
  def base, do: Cart |> from(as: :cart)

  @doc """
  Preload results with fields
  """
  def preload_by(query, fields)
  def preload_by(query, nil), do: query
  def preload_by(query, []), do: query
  def preload_by(query, fields), do: query |> preload(^fields)
end
