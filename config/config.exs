# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :wiseideas_blog, WiseideasBlog.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "oJFzNMJKO/ZXEFO/s61DHoedloo77RFTjZ0Nu48if4Ss6eFj9WAcheIHYxhZbrBJ",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: WiseideasBlog.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :wiseideas_blog, ecto_repos: [WiseideasBlog.Repo]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
