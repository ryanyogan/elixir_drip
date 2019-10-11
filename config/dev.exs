use Mix.Config

# Configure your database
config :elixir_drip, ElixirDrip.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixir_drip_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
