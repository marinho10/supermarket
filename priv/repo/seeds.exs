# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Supermarket.Repo.insert!(%Supermarket.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

p1 =
  Supermarket.Repo.insert!(
    %Supermarket.Product{}
    |> Supermarket.Product.changeset(%{
      code: "GR1",
      name: "Green Tea",
      price: 311
    })
  )

Supermarket.Repo.insert!(
  %Supermarket.Product.Rule{}
  |> Supermarket.Product.Rule.changeset(%{
    expression: "buy-one-get-one-free",
    product_id: p1.id
  })
)

p2 =
  Supermarket.Repo.insert!(
    %Supermarket.Product{}
    |> Supermarket.Product.changeset(%{
      code: "SR1",
      name: "Strawberries",
      price: 500
    })
  )

Supermarket.Repo.insert!(
  %Supermarket.Product.Rule{}
  |> Supermarket.Product.Rule.changeset(%{
    expression: ">=3=450",
    product_id: p2.id
  })
)

p3 =
  Supermarket.Repo.insert!(
    %Supermarket.Product{}
    |> Supermarket.Product.changeset(%{
      code: "CF1",
      name: "Coffee",
      price: 1123
    })
  )

Supermarket.Repo.insert!(
  %Supermarket.Product.Rule{}
  |> Supermarket.Product.Rule.changeset(%{
    expression: ">=3=(price*2/3)",
    product_id: p3.id
  })
)
