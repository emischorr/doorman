# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Dn9GoCp5xwuG1MpmowNAL57Xk0XcmA0jn1RrxGHXIyjkgmQVFcTqkf0YZ8hJoljk",
  render_errors: [view: ApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Api.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :api, Api.Guardian,
  issuer: "Doorman",
  token_ttl: %{
    "refresh" => {14, :days},
    "access" => {24, :hours}
  },
  verify_issuer: true, # optional
  secret_key: "uXBYLymdjNVMRbqsRGsB7tZitUtR2+nZcgzJuSS9QKG5VSjJNEnPG1yxJ7t8g1Np" # Secret key. You can use `mix guardian.gen.secret` to get one

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
