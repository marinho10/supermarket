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
end
