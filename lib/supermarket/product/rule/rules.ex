defmodule Supermarket.Product.Rules do
  @moduledoc """
  Product Rules context.
  """

  alias Supermarket.Product.Rule
  alias Supermarket.Product.Rule.Query
  alias Supermarket.Repo

  @doc """
  Gets a product rule by id.

  Returns `%Rule{}` or `nil`

  ## Examples

    iex> Supermarket.Product.Rules.get_by_id("aaaa-bbbb-cccc-dddd")
    %Rule{}

    iex> Supermarket.Product.Rules.get_by_id("invalid-id")
    nil

  """
  def get_by_id(id)
  def get_by_id(id) when id in [nil, ""], do: nil
  def get_by_id(id), do: Rule |> Repo.get(id)

  @doc """
  Lists all product rules

  Returns `[%Rule{}, ...]` or `[]`

  ## Examples

    iex> Supermarket.Product.Rules.list()
    [%Rule{}, ...]

  """
  def list do
    Query.base()
    |> Repo.all()
  end
end
