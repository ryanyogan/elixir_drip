defmodule ElixirDrip.Storage.Media do
  @moduledoc """
  Media creates an interface for modifying state for the Media entity.

  You will use a context to interract with this data, not directly.
  """
  defstruct id: :integer,
            filename: :string,
            full_path: :string,
            metadata: :map,
            encryption_key: :string,
            storage_key: :string

  # This file will turn into an Ecto schema,
  # the struct is temp
end
