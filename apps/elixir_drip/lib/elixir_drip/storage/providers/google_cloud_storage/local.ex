defmodule ElixirDrip.Storage.Providers.GoogleCloudStorageLocal do
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
