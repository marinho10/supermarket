defmodule SupermarketGraphQL.Cart.Query.CartTest do
  use SupermarketWeb.ConnCase, async: true

  import Supermarket.Factory

  @base_url "/api/graphql"

  setup do
    cart = insert(:cart)
    product = insert(:product)
    insert(:product_rule, %{product: product})
    insert(:cart_item, %{cart: cart, product: product})

    {:ok, %{cart: cart}}
  end

  describe "cart" do
    @cart_query """
      query cart ($id: ID!) {
        cart(id: $id) {
          id
          items {
            id
            product {
              id
            }
          }
        }
      }
    """

    @tag :normal
    test "success", %{cart: cart} do
      variables = %{"id" => cart.id}

      response =
        build_conn()
        |> post(@base_url, %{query: @cart_query, variables: variables})

      assert %{
               "data" => %{
                 "cart" => %{
                   "id" => cart_id,
                   "items" => [_]
                 }
               }
             } = json_response(response, 200)

      assert cart_id == cart.id
    end

    @tag :normal
    test "non existing id" do
      variables = %{"id" => Ecto.UUID.generate()}

      response =
        build_conn()
        |> post(@base_url, %{query: @cart_query, variables: variables})

      assert %{
               "data" => %{"cart" => nil}
             } = json_response(response, 200)
    end
  end
end
