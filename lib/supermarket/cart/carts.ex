defmodule Supermarket.Carts do
  @moduledoc """
  Carts context.
  """

  alias Supermarket.Cart
  alias Supermarket.Cart.Query
  alias Supermarket.Repo

  @doc """
  Gets a cart by id.

  Returns `%Cart{}` or `nil`

  ## Examples

    iex> Supermarket.Carts.get_by_id("aaaa-bbbb-cccc-dddd")
    %Cart{}

    iex> Supermarket.Carts.get_by_id("invalid-id")
    nil

  """
  def get_by_id(id)
  def get_by_id(id) when id in [nil, ""], do: nil
  def get_by_id(id), do: Cart |> Repo.get(id)

  @doc """
  Lists all carts

  Returns `[%Cart{}, ...]` or `[]`

  ## Examples

    iex> Supermarket.Carts.list()
    [%Cart{}, ...]

  """
  def list() do
    Query.base()
    |> Repo.all()
  end
end
