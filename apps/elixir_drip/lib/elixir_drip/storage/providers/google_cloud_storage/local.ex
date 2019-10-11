defmodule ElixirDrip.Storage.Providers.GoogleCloudStorageLocal do
  @moduledoc false
  @behaviour ElixirDrip.Behaviours.StorageProvider

  require Logger

  def upload(_path, content) do
    Logger.debug("Uploading #{inspect(byte_size(content))}")
    {:ok, :uploaded}
  end

  def download(path) do
    Logger.debug("Downloading #{path} from Google Cloud Storage")
    {:ok, "downloaded_content"}
  end
end
