defmodule Supermarket.Product.Rule do
  @moduledoc """
  Module Schema for `Rule`.
  """
  use Supermarket.Schema
  import Ecto.Changeset

  alias Supermarket.Product

  schema "product_rules" do
    field :expression, :string

    belongs_to(:product, Product)

    timestamps()
  end

  @required_fields ~w(expression product_id)a
  @optional_fields ~w()a

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:product_id, message: "invalid_identifier")
  end
end
