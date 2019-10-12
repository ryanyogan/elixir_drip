defmodule ElixirDrip.Storage.Workers.FlexibleSearchCacheWorker do
  use GenServer

  @name __MODULE__
  @search_cache :search_cache

  def start_link(storage \\ :ets) do
    GenServer.start_link(
      @name,
      storage,
      name: @name
    )
  end

  def init(storage) do
    search_cache =
      case storage do
        :ets ->
          :ets.new(@search_cache, [:named_table, :set, :protected])

        :dets ->
          {:ok, name} = :dets.open_file(@search_cache, type: :set)
          name
      end

    {:ok, {storage, search_cache}}
  end

  def terminate(_reason, {storage, search_cache}) do
    case storage do
      :dets ->
        storage.close(search_cache)

      _ ->
        :noop
    end
  end

  def search_result_for(media_id, search_expression) do
    GenServer.call(@name, {:search_result_for, media_id, search_expression})
  end

  def handle_call(
        {:search_result_for, media_id, search_expression},
        _from,
        {storage, search_cache}
      ) do
    result =
      case storage.lookup(search_cache, {media_id, search_expression}) do
        [] ->
          nil

        [{_key, {_created_at, search_result}}] ->
          search_result
      end

    {:reply, {:ok, result}, {storage, search_cache}}
  end
end
