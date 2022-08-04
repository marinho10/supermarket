defmodule Supermarket.Repo.Migrations.AddCart do
  use Ecto.Migration

  def up do
    create_if_not_exists(table(:carts)) do
      add :code, :string, null: false
      add :status, :string, null: false, default: "draft"
      add :total_price, :bigint, null: false, default: 0

      timestamps()
    end

    create_if_not_exists(unique_index(:carts, :code))
  end

  def down do
    drop_if_exists(unique_index(:carts, :code))
    drop_if_exists(table(:carts))
  end
end
