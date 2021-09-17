# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :notebookgarden,
  namespace: NotebookGarden,
  ecto_repos: [NotebookGarden.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :notebookgarden, NotebookGardenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "11H9BuEyqiy8nAzNj1O7dxXOk+CdUsXtR1k7W5Ht8nbyYRRRZg5JrborSQK5rDjV",
  render_errors: [view: NotebookGardenWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NotebookGarden.PubSub,
  live_view: [signing_salt: "6OMCipc0"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :notebookgarden, NotebookGarden.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
