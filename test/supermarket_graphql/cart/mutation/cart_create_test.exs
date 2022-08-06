defmodule SupermarketGraphQL.Cart.Mutation.CartCreateTest do
  use SupermarketWeb.ConnCase, async: true

  import Supermarket.Factory

  @base_url "/api/graphql"

  setup do
    product_1 =
      insert(:product, %{
        code: "GR1",
        name: "Green Tea",
        price: 311
      })

    insert(:product_rule, %{
      expression: "buy-one-get-one-free",
      product: product_1
    })

    product_2 =
      insert(:product, %{
        code: "SR1",
        name: "Strawberries",
        price: 500
      })

    insert(:product_rule, %{
      expression: ">=3=450",
      product: product_2
    })

    product_3 =
      insert(:product, %{
        code: "CF1",
        name: "Coffee",
        price: 1123
      })

    insert(:product_rule, %{
      expression: ">=3=(price*2/3)",
      product: product_3
    })

    {:ok, %{products: [product_1, product_2, product_3]}}
  end

  describe "create cart" do
    @mutation_cart_create """
    mutation cartCreate($basket: String!) {
      cartCreate(basket: $basket) {
          items {
            quantity
            product {
              code
            }
          }
      }
    }
    """

    @tag :normal
    test "success - GR1,SR1,GR1,GR1,CF1" do
      variables = %{"basket" => "GR1,SR1,GR1,GR1,CF1"}

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_create, variables: variables})

      assert %{
               "data" => %{
                 "cartCreate" => %{
                   "items" => [
                     %{"product" => %{"code" => "CF1"}, "quantity" => 1},
                     %{"product" => %{"code" => "GR1"}, "quantity" => 3},
                     %{"product" => %{"code" => "SR1"}, "quantity" => 1}
                   ]
                 }
               }
             } == json_response(response, 200)
    end

    @tag :normal
    test "success - GR1,GR1" do
      variables = %{"basket" => "GR1,GR1"}

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_create, variables: variables})

      assert %{
               "data" => %{
                 "cartCreate" => %{
                   "items" => [
                     %{"product" => %{"code" => "GR1"}, "quantity" => 2}
                   ]
                 }
               }
             } == json_response(response, 200)
    end

    @tag :normal
    test "success - SR1,SR1,GR1,SR1" do
      variables = %{"basket" => "SR1,SR1,GR1,SR1"}

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_create, variables: variables})

      assert %{
               "data" => %{
                 "cartCreate" => %{
                   "items" => [
                     %{"product" => %{"code" => "GR1"}, "quantity" => 1},
                     %{"product" => %{"code" => "SR1"}, "quantity" => 3}
                   ]
                 }
               }
             } == json_response(response, 200)
    end

    @tag :normal
    test "success - GR1,CF1,SR1,CF1,CF1" do
      variables = %{"basket" => "GR1,CF1,SR1,CF1,CF1"}

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_create, variables: variables})

      assert %{
               "data" => %{
                 "cartCreate" => %{
                   "items" => [
                     %{"product" => %{"code" => "CF1"}, "quantity" => 3},
                     %{"product" => %{"code" => "GR1"}, "quantity" => 1},
                     %{"product" => %{"code" => "SR1"}, "quantity" => 1}
                   ]
                 }
               }
             } == json_response(response, 200)
    end

    @tag :normal
    test "success - []" do
      variables = %{"basket" => "GR3,CF4"}

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_create, variables: variables})

      assert %{
               "data" => %{
                 "cartCreate" => %{
                   "items" => []
                 }
               }
             } == json_response(response, 200)
    end
  end
end
