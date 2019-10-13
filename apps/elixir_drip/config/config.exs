use Mix.Config

config :elixir_drip, ecto_repos: [ElixirDrip.Repo]

config :elixir_drip,
  storage_provider: ElixirDrip.Storage.Providers.GoogleCloudStorageLocal

import_config "#{Mix.env()}.exs"
