use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :soft_delete, SoftDeleteWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :soft_delete, SoftDelete.Repo,
  username: System.get_env("PGUSER") || System.get_env("POSTGRES_USER"),
  password: System.get_env("PGPASSWORD") || System.get_env("POSTGRES_PASSWORD"),
  hostname: if(System.get_env("CI"), do: "postgres", else: "localhost"),
  database: "soft_delete_test",
  pool: Ecto.Adapters.SQL.Sandbox
