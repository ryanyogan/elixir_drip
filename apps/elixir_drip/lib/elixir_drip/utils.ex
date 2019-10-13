defmodule ElixirDrip.Utils do
  @moduledoc """
  Provides a set of common helper utilities to use throughout all
  umbrella applications.
  """
  @spec generate_timestamp() :: String.t()
  def generate_timestamp do
    DateTime.utc_now()
    |> DateTime.to_iso8601(:basic)
    |> String.split(".")
    |> hd
  end
end
