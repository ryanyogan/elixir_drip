defmodule ElixirDrip.Storage.Providers.GoogleCloudStorageLocal do
  @moduledoc """
  Provides a local abstraction for interraction with our
  Google Cloud provider.  For local development and testing these callback
  functions defined [upload, download] simply log and return the
  tuple defined in `Beahviours.StorageProvider`
  """
  @behaviour ElixirDrip.Behaviours.StorageProvider

  require Logger

  @spec upload(any, any) :: {:ok, :uploaded}
  def upload(path, content) do
    Logger.info("Uploading #{inspect(byte_size(content))} bytes to #{path}")

    {:ok, :uploaded}
  end

  @spec download(any) :: {:ok, bitstring()}
  def download(path) do
    Logger.info("Downloading from #{path}...")

    {:ok, "downloaded_content"}
  end
end
