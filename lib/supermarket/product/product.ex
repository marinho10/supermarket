defmodule Supermarket.Product do
  @moduledoc """
  Module Schema for `Product`.
  """
  use Supermarket.Schema
  import Ecto.Changeset

  schema "products" do
    field :code, :string
    field :name, :string
    field :price, :integer

    timestamps()
  end

  @required_fields ~w(code name price)a
  @optional_fields ~w()a

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:code, message: "code_been_taken")
  end
end
