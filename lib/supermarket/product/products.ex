defmodule Supermarket.Products do
  @moduledoc """
  Products context.
  """

  alias Supermarket.Product
  alias Supermarket.Product.Query
  alias Supermarket.Repo

  @doc """
  Gets a product by id.

  Returns `%Product{}` or `nil`

  ## Examples

    iex> Supermarket.Products.get_by_id("aaaa-bbbb-cccc-dddd")
    %Product{}

    iex> Supermarket.Products.get_by_id("invalid-id")
    nil

  """
  def get_by_id(id)
  def get_by_id(id) when id in [nil, ""], do: nil
  def get_by_id(id), do: Product |> Repo.get(id)

  @doc """
  Gets a product by code.

  Returns `%Product{}` or `nil`

  ## Examples

    iex> Supermarket.Products.get_by_code("CR1")
    %Product{}

    iex> Supermarket.Products.get_by_code("invalid-id")
    nil

  """
  def get_by_code(code)
  def get_by_code(code) when code in [nil, ""], do: nil
  def get_by_code(code), do: Product |> Repo.get_by(code: code)

  @doc """
  Lists all products

  Returns `[%Product{}, ...]` or `[]`

  ## Examples

    iex> Supermarket.Products.list()
    [%Product{}, ...]

  """
  def list do
    Query.base()
    |> Repo.all()
  end
end
