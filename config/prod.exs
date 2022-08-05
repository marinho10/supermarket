import Config

# General configuration
config :supermarket,
  ecto_repos: [Supermarket.Repo],
  cookie_domain: System.get_env("COOKIE_DOMAIN") || "localhost",
  cookie_secure: true

# Elixir's Logger configuration
config :logger, level: :info

# Repo configuration
config :supermarket, Supermarket.Repo,
  username: System.get_env("REPO_USERNAME"),
  password: System.get_env("REPO_PASSWORD"),
  database: System.get_env("REPO_DATABASE"),
  hostname: System.get_env("REPO_HOSTNAME"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Endpoint configuration
secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

# Endpoint configuration
config :threat_optix, SupermarketWeb.Endpoint,
  url: [host: System.get_env("URL_HOST") || "example.com", port: 443],
  load_from_system_env: false,
  server: true,
  http: [
    :inet6,
    ip: {0, 0, 0, 0, 0, 0, 0, 0},
    port: String.to_integer(System.get_env("PORT") || "4000"),
    protocol_options: [idle_timeout: :infinity]
  ],
  secret_key_base: secret_key_base,
  debug_errors: false,
  check_origin: false
