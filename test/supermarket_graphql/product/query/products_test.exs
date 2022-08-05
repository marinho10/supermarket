defmodule SupermarketGraphQL.Product.Query.ProductsTest do
  use SupermarketWeb.ConnCase, async: true

  import Supermarket.Factory

  @base_url "/api/graphql"

  setup do
    products = insert_list(5, :product)

    {:ok, %{products: products}}
  end

  describe "products" do
    @products_query """
      query products {
        products {
          id
          code
          rules {
            id
            expression
          }
        }
      }
    """

    @tag :normal
    test "success" do
      response =
        build_conn()
        |> post(@base_url, %{query: @products_query, variables: %{}})

      assert %{
               "data" => %{
                 "products" => products_result
               }
             } = json_response(response, 200)

      assert length(products_result) == 5
    end
  end
end
