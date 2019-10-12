defmodule ElixirDrip.Storage.Workers.SearchCacheWorker do
  @moduledoc false

  use GenServer

  @name __MODULE__
  @search_cache :search_cache
  @expiration_seconds 60

  def search_result_for(media_id, search_expression) do
    case :ets.lookup(@search_cache, {media_id, search_expression}) do
      [] ->
        nil

      [{_key, {_created_at, search_result}}] ->
        search_result
    end
  end

  def all_search_results_for(media_id) do
    case :ets.match_object(@search_cache, {{media_id, :_}, :_}) do
      [] ->
        nil

      all_objects ->
        all_objects
        |> Enum.map(fn {key, value} ->
          {elem(key, 1), elem(value, 1)}
        end)
    end
  end

  def expired_search_results(expiration_seconds \\ @expiration_seconds) do
    query = expired_search_results_query(expiration_seconds)

    :ets.select(@search_cache, query)
  end

  defp expired_search_results_query(expiration_seconds) do
    expiration_time = :os.system_time(:seconds) - expiration_seconds

    [
      {
        {:"$1", {:"$2", :_}},
        [{:<, :"$2", {:const, expiration_time}}],
        [:"$1"]
      }
    ]
  end

  def delete_cache_search(media_id, search_expression) do
    GenServer.call(@name, {:delete, [{media_id, search_expression}]})
  end

  def delete_cache_search(keys) when is_list(keys) and length(keys) > 0 do
    GenServer.call(@name, {:delete, keys})
  end

  def start_link() do
    GenServer.start_link(@name, [], name: @name)
  end

  def init(_) do
    search_cache = :ets.new(@search_cache, [:named_table, :set, :protected])

    {:ok, search_cache}
  end

  def cache_search_result(media_id, search_expression, result) do
    GenServer.call(
      @name,
      {:put, media_id, search_expression, result}
    )
  end

  def handle_call({:put, media_id, search_expression, result}, _from, search_cache) do
    created_at = :os.system_time(:seconds)

    result =
      :ets.insert_new(search_cache, {
        {media_id, search_expression},
        {created_at, result}
      })

    {:reply, {:ok, result}, search_cache}
  end

  def handle_call({:delete, keys}, _from, search_cache) when is_list(keys) do
    result =
      delete(keys)
      |> Enum.reduce(true, fn r, acc -> r && acc end)

    {:reply, {:ok, result}, search_cache}
  end

  defp delete([]), do: []

  defp delete([key | rest]),
    do: [delete(key)] ++ delete(rest)

  defp delete(key), do: :ets.delete(@search_cache, key)
end
