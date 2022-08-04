defmodule Supermarket.Repo.Migrations.AddCartItem do
  use Ecto.Migration

  def up do
    create_if_not_exists(table(:cart_items)) do
      add :quantity, :bigint, default: 0
      add :unit_price, :bigint, default: 0
      add :one_free, :boolean, default: false
      add :product_id, references(:products, on_delete: :delete_all), null: false
      add :cart_id, references(:products, on_delete: :delete_all), null: false

      timestamps()
    end

    create_if_not_exists(index(:cart_items, :product_id))
    create_if_not_exists(index(:cart_items, :cart_id))
  end

  def down do
    drop_if_exists(index(:cart_items, :product_id))
    drop_if_exists(index(:cart_items, :cart_id))
    drop_if_exists(table(:cart_items))
  end
end
