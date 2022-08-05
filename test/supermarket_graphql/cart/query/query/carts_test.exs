defmodule SupermarketGraphQL.Cart.Query.CartsTest do
  use SupermarketWeb.ConnCase, async: true

  import Supermarket.Factory

  @base_url "/api/graphql"

  setup do
    carts = insert_list(5, :cart)

    {:ok, %{carts: carts}}
  end

  describe "carts" do
    @cart_query """
      query carts {
        carts {
          id
          code
        }
      }
    """

    @tag :normal
    test "success" do
      response =
        build_conn()
        |> post(@base_url, %{query: @cart_query, variables: %{}})

      assert %{
               "data" => %{
                 "carts" => carts_result
               }
             } = json_response(response, 200)

      assert length(carts_result) == 5
    end
  end
end
