defmodule Supermarket.Cart.Items do
  @moduledoc """
  Cart Items context.
  """

  alias Supermarket.Cart.Item
  alias Supermarket.Cart.Item.Query
  alias Supermarket.Repo

  @doc """
  Gets a cart item by id.

  Returns `%Item{}` or `nil`

  ## Examples

    iex> Supermarket.Cart.Items.get_by_id("aaaa-bbbb-cccc-dddd")
    %Item{}

    iex> Supermarket.Cart.Items.get_by_id("invalid-id")
    nil

  """
  def get_by_id(id)
  def get_by_id(id) when id in [nil, ""], do: nil
  def get_by_id(id), do: Item |> Repo.get(id)

  @doc """
  Lists all cart items

  Returns `[%Item{}, ...]` or `[]`

  ## Examples

    iex> Supermarket.Cart.Items.list()
    [%Item{}, ...]

  """
  def list() do
    Query.base()
    |> Repo.all()
  end
end
