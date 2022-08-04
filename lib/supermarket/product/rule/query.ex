defmodule Supermarket.Product.Rule.Query do
  @moduledoc """
  Product Rule queries context.
  """

  import Ecto.Query, warn: false

  alias Supermarket.Product.Rule

  @doc """
  Base query for Product rules.
  """
  def base, do: Rule |> from(as: :rule)
end
