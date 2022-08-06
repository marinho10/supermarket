defmodule Supermarket.Repo.Migrations.AddCart do
  use Ecto.Migration

  def up do
    create_if_not_exists(table(:carts)) do
      add :status, :string, null: false, default: "draft"
      add :total_price, :bigint

      timestamps()
    end
  end

  def down do
    drop_if_exists(table(:carts))
  end
end
