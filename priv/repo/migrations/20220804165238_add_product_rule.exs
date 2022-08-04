defmodule Supermarket.Repo.Migrations.AddProductRule do
  use Ecto.Migration

  def up do
    create_if_not_exists(table(:product_rules)) do
      add :expression, :string, null: false
      add :product_id, references(:products, on_delete: :delete_all), null: false

      timestamps()
    end

    create_if_not_exists(index(:product_rules, :product_id))
  end

  def down do
    drop_if_exists(index(:product_rules, :product_id))
    drop_if_exists(table(:product_rules))
  end
end
