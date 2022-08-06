defmodule SupermarketGraphQL.Cart.Mutation.CartCompleteTest do
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
      expression: "quantity>=3=>450",
      product: product_2
    })

    product_3 =
      insert(:product, %{
        code: "CF1",
        name: "Coffee",
        price: 1123
      })

    insert(:product_rule, %{
      expression: "quantity>=3=>price*2/3",
      product: product_3
    })

    {:ok, %{products: [product_1, product_2, product_3]}}
  end

  describe "complete cart" do
    @mutation_cart_create """
    mutation cartCreate($basket: String!) {
      cartCreate(basket: $basket) {
          id
      }
    }
    """

    @mutation_cart_complete """
    mutation cartComplete($id: ID!) {
      cartComplete(id: $id) {
          items {
            quantity
            free
            unit_price
            product {
              code
            }
          }
          final_price
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
                   "id" => cart_id
                 }
               }
             } = json_response(response, 200)

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_complete, variables: %{id: cart_id}})

      assert %{
               "data" => %{
                 "cartComplete" => %{
                   "final_price" => "£22.45",
                   "items" => [
                     %{
                       "free" => false,
                       "product" => %{"code" => "CF1"},
                       "quantity" => 1,
                       "unit_price" => 1123
                     },
                     %{
                       "free" => true,
                       "product" => %{"code" => "GR1"},
                       "quantity" => 3,
                       "unit_price" => 311
                     },
                     %{
                       "free" => false,
                       "product" => %{"code" => "SR1"},
                       "quantity" => 1,
                       "unit_price" => 500
                     }
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
                   "id" => cart_id
                 }
               }
             } = json_response(response, 200)

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_complete, variables: %{id: cart_id}})

      assert %{
               "data" => %{
                 "cartComplete" => %{
                   "final_price" => "£3.11",
                   "items" => [
                     %{
                       "free" => true,
                       "product" => %{"code" => "GR1"},
                       "quantity" => 2,
                       "unit_price" => 311
                     }
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
                   "id" => cart_id
                 }
               }
             } = json_response(response, 200)

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_complete, variables: %{id: cart_id}})

      assert %{
               "data" => %{
                 "cartComplete" => %{
                   "final_price" => "£16.61",
                   "items" => [
                     %{"free" => true, "product" => %{"code" => "GR1"}, "quantity" => 1, "unit_price" => 311},
                     %{"free" => false, "product" => %{"code" => "SR1"}, "quantity" => 3, "unit_price" => 450}
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
                   "id" => cart_id
                 }
               }
             } = json_response(response, 200)

      response =
        build_conn()
        |> post(@base_url, %{query: @mutation_cart_complete, variables: %{id: cart_id}})

      assert %{
               "data" => %{
                 "cartComplete" => %{
                   "final_price" => "£30.58",
                   "items" => [
                     %{
                       "free" => false,
                       "product" => %{"code" => "CF1"},
                       "quantity" => 3,
                       "unit_price" => 749
                     },
                     %{
                       "free" => true,
                       "product" => %{"code" => "GR1"},
                       "quantity" => 1,
                       "unit_price" => 311
                     },
                     %{
                       "free" => false,
                       "product" => %{"code" => "SR1"},
                       "quantity" => 1,
                       "unit_price" => 500
                     }
                   ]
                 }
               }
             } == json_response(response, 200)
    end
  end
end
