# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_practice,
  ecto_repos: [PhoenixPractice.Repo]

# Configures the endpoint
config :phoenix_practice, PhoenixPracticeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GMWc/o8jFCPEg3i55AOgkBCwJvDp2wyQvbn4TzmoZTFckFzcZFkLIQqc3jLoyKED",
  render_errors: [view: PhoenixPracticeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixPractice.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "f+Sx59BN"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
