import Config

# Repo configuration
config :supermarket, Supermarket.Repo,
  url: "ecto://postgres:postgres@localhost/supermarket_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  ownership_timeout: 10 * 60 * 1000,
  pool_size: 30

# Endpoint configuration
config :supermarket, SupermarketWeb.Endpoint,
  http: [port: 4002],
  server: false

# Elixir's Logger configuration
config :logger, level: :warn
