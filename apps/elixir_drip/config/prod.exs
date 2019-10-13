use Mix.Config

config :elixir_drip,
  storage_provider: ElixirDrip.Storage.Providers.GoogleCloudStorageLive

import_config "prod.secret.exs"
