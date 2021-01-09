# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pi_stats_live,
  ecto_repos: [PiStatsLive.Repo]

# Configures the endpoint
config :pi_stats_live, PiStatsLiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JWinGG/GbRb+LZe0yCQyBDdYiSSDOC9gXApfqTND2IPxrUt5zHYtXbv8M7e38gLz",
  render_errors: [view: PiStatsLiveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PiStatsLive.PubSub,
  live_view: [signing_salt: "4aThxale"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
