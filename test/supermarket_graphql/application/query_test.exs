defmodule SupermarketGraphQL.Application.QueryTest do
  use SupermarketWeb.ConnCase

  describe "application" do
    @query """
    query {
      application {
        version
      }
    }
    """

    @tag :normal
    test "version" do
      response =
        post(build_conn(), "/api/graphql", %{
          query: @query,
          variables: %{}
        })

      version = Application.spec(:supermarket, :vsn)

      assert %{
               "data" => %{
                 "application" => %{
                   "version" => to_string(version)
                 }
               }
             } === json_response(response, 200)
    end
  end
end
