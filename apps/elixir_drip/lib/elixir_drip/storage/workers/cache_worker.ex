defmodule ElixirDrip.Storage.Workers.CacheWorker do
  use GenServer

  @name __MODULE__
  @expire_time 60_000

  def start_link(media_id, content) do
    GenServer.start_link(@name, content, name: name_for(media_id))
  end

  def name_for(media_id),
    do: {:via, Registry, {ElixirDrip.Registry, {:cache, media_id}}}

  @impl true
  def init(content) do
    timer = Process.send_after(self(), :expire, @expire_time)
    {:ok, %{hits: 0, content: content, timer: timer}}
  end

  @impl true
  def handle_info(:expire, %{hits: hits} = state) do
    IO.puts("#{inspect(self())}: Terminating cache, served #{hits} hits.")
    {:stop, :normal, state}
  end

  @impl true
  def handle_info(_msg, state), do: {:noreply, state}

  def get_media(pid), do: GenServer.call(pid, :get_media)

  @impl true
  def handle_call(:get_media, _from, %{hits: hits, content: content, timer: timer} = state) do
    {:reply, {:ok, content}, %{state | hits: hits + 1, timer: refresh_timer(timer)}}
  end

  def refresh(pid), do: GenServer.cast(pid, :refresh)

  @impl true
  def handle_cast(:refresh, %{timer: timer} = state),
    do: {:noreply, %{state | timer: refresh_timer(timer)}}

  defp refresh_timer(timer) do
    Process.cancel_timer(timer)
    Process.send_after(self(), :expire, @expire_time)
  end
end
