defmodule Supermarket.Cart.Items do
  @moduledoc """
  Cart Items context.
  """

  alias Supermarket.Cart.Item.Query
  alias Supermarket.Repo

  @doc """
  Delete all items by cart id

  Returns `{number_deleted, nil | term}`

  ## Examples

    iex> Supermarket.Carts.delete_all("aaaa-bbbb-cccc-dddd")
    {10, nil | term}

    iex> Supermarket.Carts.delete_all("invalid-id")
    {0, nil | term}

  """
  def delete_all(cart_id) do
    Query.base()
    |> Query.filter_by_cart_id(cart_id)
    |> Repo.delete_all(timeout: :infinity)
  end
end
