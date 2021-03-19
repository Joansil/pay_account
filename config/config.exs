# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pay_account,
  ecto_repos: [PayAccount.Repo]

# Configures the endpoint
config :pay_account, PayAccountWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "d+hmMbiE2GWmVNzLKu6KeXKIdP0KVGe+I/N37coXqTuIr9DVk/HU4RtGn+Vq4MEJ",
  render_errors: [view: PayAccountWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PayAccount.PubSub,
  live_view: [signing_salt: "ij7B6SpB"]

config :pay_account, PayAccount.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :pay_account, :basic_auth,
  username: "user",
  password: "user"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
