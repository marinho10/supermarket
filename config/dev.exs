import Config

# Repo configuration
config :supermarket, Supermarket.Repo,
  url: "ecto://postgres:postgres@localhost/supermarket_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Endpoint configuration
config :supermarket, SupermarketWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Elixir's Logger configuration
config :logger, :console, format: "[$level] $message\n"

# Phoenix configuration - stacktrace_depth
config :phoenix, :stacktrace_depth, 20

# Phoenix configuration - plug_init_mode
config :phoenix, :plug_init_mode, :runtime
