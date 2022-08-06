defmodule Supermarket.Cart do
  @moduledoc """
  Module Schema for `Cart`.
  """
  use Supermarket.Schema
  import Ecto.Changeset

  alias Supermarket.Cart.Item

  @status [:draft, :completed]
  def all_status, do: @status

  schema "carts" do
    field :status, Ecto.Enum, values: @status, default: :draft
    field :total_price, :integer

    has_many(:items, Item, on_delete: :delete_all)

    timestamps()
  end

  @required_fields ~w(status)a
  @optional_fields ~w(total_price)a

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
