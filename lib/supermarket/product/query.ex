defmodule Supermarket.Product.Query do
  @moduledoc """
  Product queries context.
  """

  import Ecto.Query, warn: false

  alias Supermarket.Product

  @doc """
  Base query for Products.
  """
  def base, do: Product |> from(as: :product)
end
