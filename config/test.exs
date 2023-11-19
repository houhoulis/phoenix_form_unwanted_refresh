import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :phoenix179, Phoenix179.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "phoenix179_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix179_web, Phoenix179Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "A+QfsU46EQZpdOABvOnuzWVgonjK09h/Kh5T7eE49Ax+KqEK2xgpDjsunZte3I0f",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
config :phoenix179, Phoenix179.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
