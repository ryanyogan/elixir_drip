defmodule ElixirDrip.Storage do
  @moduledoc false

  alias ElixirDrip.Utils

  alias ElixirDrip.Storage.{
    Provider,
    Media
  }

  @spec store(Media.t(), any) :: {:ok, :uploaded}
  def store(%Media{} = media, content) do
    media
    |> generate_storage_key()
    |> Map.get(:storage_key)
    |> Provider.upload(content)
  end

  @spec retreive(Media.t()) :: {:ok, bitstring()}
  def retreive(%Media{storage_key: storage_key}) do
    Provider.download(storage_key)
  end

  defp generate_storage_key(%Media{id: id} = media) do
    %{media | storage_key: id <> "_" <> Utils.generate_timestamp()}
  end
end
