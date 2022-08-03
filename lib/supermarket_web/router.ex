defmodule SupermarketWeb.Router do
  use SupermarketWeb, :router

  pipeline :graphql do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:put_secure_browser_headers)
    plug(SupermarketGraphQL.Context)
  end

  scope "/api" do
    pipe_through :graphql

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: SupermarketGraphQL.Schema
    forward "/graphql", Absinthe.Plug, schema: SupermarketGraphQL.Schema
  end
end
