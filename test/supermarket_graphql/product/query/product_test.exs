defmodule SupermarketGraphQL.Product.Query.ProductTest do
  use SupermarketWeb.ConnCase, async: true

  import Supermarket.Factory

  @base_url "/api/graphql"

  setup do
    product = insert(:product)
    insert(:product_rule, %{product: product})

    {:ok, %{product: product}}
  end

  describe "product" do
    @cart_query """
      query product ($id: ID!) {
        product(id: $id) {
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
    test "success", %{product: product} do
      variables = %{"id" => product.id}

      response =
        build_conn()
        |> post(@base_url, %{query: @cart_query, variables: variables})

      assert %{
               "data" => %{
                 "product" => %{
                   "id" => product_id,
                   "code" => _,
                   "rules" => [_]
                 }
               }
             } = json_response(response, 200)

      assert product_id == product.id
    end

    @tag :normal
    test "non existing id" do
      variables = %{"id" => Ecto.UUID.generate()}

      response =
        build_conn()
        |> post(@base_url, %{query: @cart_query, variables: variables})

      assert %{
               "data" => %{"product" => nil}
             } = json_response(response, 200)
    end
  end
end
