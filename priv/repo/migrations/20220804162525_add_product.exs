defmodule Supermarket.Repo.Migrations.AddProduct do
  use Ecto.Migration

  def up do
    create_if_not_exists(table(:products)) do
      add :code, :string, null: false
      add :name, :string, null: false
      add :price, :bigint, null: false

      timestamps()
    end

    create_if_not_exists(unique_index(:products, :code))
  end

  def down do
    drop_if_exists(unique_index(:products, :code))
    drop_if_exists(table(:products))
  end
end
