defmodule Supermarket.Carts do
  @moduledoc """
  Carts context.
  """

  alias Ecto.Multi
  alias Supermarket.Cart
  alias Supermarket.Cart.Item
  alias Supermarket.Cart.Items
  alias Supermarket.Cart.Query
  alias Supermarket.Products
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
  @preload_fields [items: [product: :rules]]
  def get_by_id(id)
  def get_by_id(id) when id in [nil, ""], do: nil
  def get_by_id(id), do: Cart |> Query.preload_by(@preload_fields) |> Repo.get(id)

  @doc """
  Lists all carts

  Returns `[%Cart{}, ...]` or `[]`

  ## Examples

    iex> Supermarket.Carts.list()
    [%Cart{}, ...]

  """
  def list do
    Query.base()
    |> Repo.all()
  end

  @doc """
  Create cart by basket(string param)

  Returns `%Cart{}` or `nil`

  ## Examples

    iex> Supermarket.Carts.create("GR1,SR1,GR1,GR1,CF1")
    %Cart{}

    iex> Supermarket.Carts.create("invalid-id")
    nil

  """
  def create(basket)
  def create(basket) when basket in [nil, ""], do: nil

  def create(basket) do
    timestamp = DateTime.truncate(DateTime.utc_now(), :second)

    items_attrs =
      String.split(basket, ",")
      |> Enum.group_by(& &1)
      |> Enum.map(fn {code, items} -> %{product: Products.get_by_code(code), quantity: length(items)} end)
      |> Enum.reject(fn %{product: product} -> is_nil(product) end)
      |> Enum.map(
        &%{
          product_id: &1.product.id,
          quantity: &1.quantity,
          inserted_at: timestamp,
          updated_at: timestamp
        }
      )

    Multi.new()
    |> Multi.insert(:cart, Cart.changeset(%Cart{}, %{status: :draft}))
    |> Multi.insert_all(:cart_items, Item, fn %{cart: cart} ->
      items_attrs
      |> Enum.map(&Map.put(&1, :cart_id, cart.id))
    end)
    |> Repo.transaction()
    |> handle_create_cart()
  end

  defp handle_create_cart({:ok, %{cart: cart}}) do
    {:ok, get_by_id(cart.id)}
  end

  defp handle_create_cart({:error, _, changeset, _}), do: {:error, changeset}

  @doc """
  Complete cart by id

  Returns `%Cart{}` or `nil`

  ## Examples

    iex> Supermarket.Carts.complete("aaaa-bbbb-cccc-dddd")
    %Cart{}

    iex> Supermarket.Carts.complete("invalid-id")
    nil

  """
  def complete(id)
  def complete(id) when id in [nil, ""], do: {:ok, nil}

  def complete(id) do
    get_by_id(id) |> complete_aux()
  end

  defp complete_aux(nil), do: {:ok, nil}

  defp complete_aux(cart) do
    Multi.new()
    |> Multi.run(:items, fn _, _ ->
      items =
        cart.items
        |> Enum.map(&calculate_item(&1))
        |> List.flatten()

      {:ok, items}
    end)
    |> Multi.run(:total_price, fn _, %{items: items} ->
      {:ok, calculate_total_price(items)}
    end)
    |> Multi.update(:cart, fn %{total_price: total_price} ->
      Cart.changeset(cart, %{status: :completed, total_price: total_price})
    end)
    |> Multi.run(:delete_cart_items, fn _, _ ->
      {:ok, Items.delete_all(cart.id)}
    end)
    |> Multi.insert_all(:cart_items, Item, fn %{items: items} ->
      items
    end)
    |> Repo.transaction()
    |> handle_complete_cart()
  end

  defp calculate_item(
         %{
           product: %{
             price: price,
             rules: [%{expression: "buy-one-get-one-free"}]
           }
         } = item
       ) do
    [
      %{
        cart_id: item.cart_id,
        product_id: item.product_id,
        quantity: item.quantity,
        unit_price: price,
        free: true,
        inserted_at: item.inserted_at,
        updated_at: item.updated_at
      }
    ]
  end

  defp calculate_item(
         %{
           quantity: quantity,
           product: %{
             price: price,
             rules: [%{expression: expression}]
           }
         } = item
       ) do
    with [condition_expression, price_expression] <- expression |> String.split("=>"),
         condition_expression <- String.replace(condition_expression, "quantity", "#{quantity}"),
         price_expression <- String.replace(price_expression, "price", "#{price}"),
         {true, []} <- Code.eval_string(condition_expression),
         {price, []} <- Code.eval_string(price_expression),
         price <- round(price) do
      [
        %{
          cart_id: item.cart_id,
          product_id: item.product_id,
          quantity: item.quantity,
          unit_price: price,
          free: false,
          inserted_at: item.inserted_at,
          updated_at: item.updated_at
        }
      ]
    else
      _ ->
        [
          %{
            cart_id: item.cart_id,
            product_id: item.product_id,
            quantity: item.quantity,
            unit_price: item.product.price,
            free: false,
            inserted_at: item.inserted_at,
            updated_at: item.updated_at
          }
        ]
    end
  end

  defp calculate_item(item),
    do: [
      %{
        cart_id: item.cart_id,
        product_id: item.product_id,
        quantity: item.quantity,
        unit_price: item.product.price,
        free: false,
        inserted_at: item.inserted_at,
        updated_at: item.updated_at
      }
    ]

  defp calculate_total_price(items) when items in [nil, "", []], do: 0

  defp calculate_total_price(items) do
    Enum.reduce(items, 0, fn %{quantity: quantity, unit_price: unit_price, free: free}, acc ->
      cond do
        quantity == 1 ->
          unit_price + acc

        free ->
          unit_price * (quantity - 1) + acc

        true ->
          unit_price * quantity + acc
      end
    end)
    |> round()
  end

  defp handle_complete_cart({:ok, %{cart: cart}}) do
    {:ok, get_by_id(cart.id)}
  end

  defp handle_complete_cart({:error, _, changeset, _}), do: {:error, changeset}
end
