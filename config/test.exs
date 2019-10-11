use Mix.Config

# Configure your database
config :elixir_drip, ElixirDrip.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixir_drip_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
