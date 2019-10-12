defmodule ElixirDrip.Storage.Workers.AgentCacheWorker do
  use Agent
  alias ElixirDrip.Storage.Workers.CacheWorker

  def start_link(media_id, content) do
    Agent.start_link(
      fn ->
        %{hits: 0, content: content}
      end,
      name: CacheWorker.name_for(media_id)
    )
  end

  def get_media(pid),
    do:
      Agent.get_and_update(
        pid,
        fn %{hits: hits, content: _content} = state ->
          {state.content, %{state | hits: hits + 1}}
        end
      )
end
