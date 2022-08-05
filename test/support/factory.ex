defmodule Supermarket.Factory do
  @moduledoc """
  Factory (ExMachina)
  """
  use ExMachina.Ecto, repo: Supermarket.Repo

  alias Supermarket.Cart
  alias Supermarket.Cart.Item
  alias Supermarket.Product
  alias Supermarket.Product.Rule

  # This is a sample factory to make sure our setup is working correctly.
  def name_factory(_) do
    Faker.Person.name()
  end

  def product_factory do
    %Product{
      code: sequence(:product_code, &"product_code-#{&1}"),
      name: sequence(:product_name, &"product_name-#{&1}"),
      price: Enum.random(100..11_000)
    }
  end

  def product_rule_factory do
    %Rule{
      expression: sequence(:product_rule_expression, ["buy-one-get-one-free", ">=3=100"]),
      product: build(:product)
    }
  end

  def cart_factory do
    %Cart{
      code: sequence(:cart_code, &"cart_code-#{&1}"),
      status: sequence(:cart_status, Cart.all_status()),
      total_price: Enum.random(100..11_000)
    }
  end

  def cart_item_factory do
    %Item{
      quantity: Enum.random(1..10),
      unit_price: Enum.random(100..11_000),
      one_free: sequence(:cart_item_one_free, [true, false]),
      cart: build(:cart),
      product: build(:product)
    }
  end
end
