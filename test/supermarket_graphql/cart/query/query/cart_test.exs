defmodule SupermarketGraphQL.Cart.Query.CartTest do
  use SupermarketWeb.ConnCase, async: true

  import Supermarket.Factory

  @base_url "/api/graphql"

  setup do
    cart = insert(:cart)

    {:ok, %{cart: cart}}
  end

  describe "cart" do
    @cart_query """
      query cart ($id: ID!) {
        cart(id: $id) {
          id
          code
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
                   "id" => cart.id,
                   "code" => cart.code
                 }
               }
             } == json_response(response, 200)
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
