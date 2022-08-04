defmodule Supermarket.Cart.Item do
  @moduledoc """
  Module Schema for `Item`.
  """
  use Supermarket.Schema
  import Ecto.Changeset

  alias Supermarket.Cart
  alias Supermarket.Product

  @status [:draft, :completed]
  def all_status, do: @status

  schema "cart_items" do
    field :quantity, :integer, default: 0
    field :unit_price, :integer, default: 0
    field :one_free, :boolean, default: false

    belongs_to(:product, Product)
    belongs_to(:cart, Cart)

    timestamps()
  end

  @required_fields ~w(quantity unit_price one_free product_id cart_id)a
  @optional_fields ~w()a

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:product_id, message: "invalid_identifier")
    |> foreign_key_constraint(:cart_id, message: "invalid_identifier")
  end
end
