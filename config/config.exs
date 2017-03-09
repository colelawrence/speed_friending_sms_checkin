# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :speedfriending_sms,
  ecto_repos: [SfSms.Repo]

# Configures the endpoint
config :speedfriending_sms, SfSms.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CXoWQUAxNxZfz0vU99UcTQDJ4bMq0xrsUEZCXdmy/uMDvjR+c+rBLRixmHvBcagX",
  render_errors: [view: SfSms.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SfSms.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


# Twilio Test Messaging Setup
config :ex_twilio, account_sid: System.get_env("GA_TWILIO_ACCOUNT_SID")
config :ex_twilio, auth_token:  System.get_env("GA_TWILIO_AUTH_TOKEN")
config :ex_twilio, send_number: System.get_env("GA_TWILIO_SEND_NUMBER")
config :ex_twilio, basic_auth:  System.get_env("GA_TWILIO_HTTP_BASIC_AUTH")

config :speedfriending_sms, groupme_access_token: System.get_env("GA_GROUPME_ACCESS_TOKEN")

config :speedfriending_sms, send_verify_from:  System.get_env("GA_SEND_VERIFY_FROM")
config :speedfriending_sms, send_notify_from:  System.get_env("GA_SEND_NOTIFY_FROM")

# SMTP Emailing Setup
config :speedfriending_sms, SfSms.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: System.get_env("GA_SMTP_SERVER_NAME"),
  port: 465,
  username: System.get_env("GA_SMTP_USERNAME"),
  password: System.get_env("GA_SMTP_PASSWORD"),
  tls: :if_available, # can be `:always` or `:never`
  ssl: true, # can be `true`
  retries: 1


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
