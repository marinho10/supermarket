defmodule SupermarketGraphQL.Dataloader do
  @moduledoc """
  Dataloader source
  """
  import Ecto.Query, warn: false

  alias Supermarket.Cart
  alias Supermarket.Cart.Item
  alias Supermarket.Product
  alias Supermarket.Product.Rule
  alias Supermarket.Repo

  ### DATALOADER DATASOURCE

  def data, do: Dataloader.Ecto.new(Repo, query: &query/2)

  ### DATALOADER QUERY

  def query(Cart, attrs) do
    attrs
    |> Map.put_new(:order, :inserted_at)
    |> Enum.reduce(Cart, &apply_param/2)
  end

  def query(Item, attrs) do
    attrs
    |> Map.put_new(:order, :inserted_at)
    |> Enum.reduce(Item, &apply_param/2)
  end

  def query(Product, attrs) do
    attrs
    |> Map.put_new(:order, :inserted_at)
    |> Enum.reduce(Product, &apply_param/2)
  end

  def query(Rule, attrs) do
    attrs
    |> Map.put_new(:order, :inserted_at)
    |> Enum.reduce(Rule, &apply_param/2)
  end

  def query(queryable, _params), do: queryable

  @doc """
  reduce function
  """
  def apply_param({:order, {:asc, field}}, queryable),
    do: queryable |> order_by(asc: ^field)

  def apply_param({:order, {:asc_nulls_last, field}}, queryable),
    do: queryable |> order_by(desc: ^field)

  def apply_param({:order, {:desc, field}}, queryable),
    do: queryable |> order_by(desc: ^field)

  def apply_param({:order, field}, queryable),
    do: queryable |> order_by(asc: ^field)

  def apply_param({:id, id}, queryable),
    do: queryable |> where(id: ^id)

  def apply_param(_param, queryable), do: queryable
end
