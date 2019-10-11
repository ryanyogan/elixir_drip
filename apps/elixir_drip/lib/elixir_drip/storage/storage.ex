defmodule ElixirDrip.Storage do
  @moduledoc false

  alias ElixirDrip.Storage.{Media, Provider}

  def store(%Media{} = media, content) do
    media
    |> generate_storage_key()
    |> Map.get(:storage_key)
    |> Provider.upload(content)
  end

  def retreive(%Media{storage_key: storage_key}) do
    Provider.download(storage_key)
  end

  defp generate_storage_key(_args) do
    %{}
  end
end
