defmodule ElixirDrip.Utils do
  @spec generate_timestamp() :: String.t()
  def generate_timestamp do
    DateTime.utc_now()
    |> DateTime.to_iso8601(:basic)
    |> String.split(".")
    |> hd
  end
end
