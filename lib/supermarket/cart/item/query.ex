defmodule Supermarket.Cart.Item.Query do
  @moduledoc """
  Cart Item queries context.
  """

  import Ecto.Query, warn: false

  alias Supermarket.Cart.Item

  @doc """
  Base query for Cart Items.
  """
  def base, do: Item |> from(as: :item)
end
