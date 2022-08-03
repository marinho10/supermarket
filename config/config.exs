# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

# General configuration
config :supermarket,
  ecto_repos: [Supermarket.Repo]

# Repo configuration
config :supermarket, Supermarket.Repo, migration_primary_key: [name: :id, type: :binary_id]

# Endpoint configuration
config :supermarket, SupermarketWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vFARunaybVxzlIZHxm2P8m6xmA6IaIeSF1X3ZFNSHPBNXqc2GpiRPcILldr5QS11",
  render_errors: [view: SupermarketWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Supermarket.PubSub

# CORS configuration
config :cors_plug,
  origin: "*",
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "DELETE"]

# Elixir's Logger configuration
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Jason configuration
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
