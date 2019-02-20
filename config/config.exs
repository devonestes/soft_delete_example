# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :soft_delete,
  ecto_repos: [SoftDelete.Repo]

# Configures the endpoint
config :soft_delete, SoftDeleteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nz8a5aYo3nu6rmjriBuKN6D5N7Nc3FMIb+vdCtbQCY2EH699o83FfAtqxKyLX7OC",
  render_errors: [view: SoftDeleteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SoftDelete.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
