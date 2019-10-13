defmodule ElixirDrip.Storage.Media do
  defstruct id: :integer,
            filename: :string,
            full_path: :string,
            metadata: :map,
            encryption_key: :string,
            storage_key: :string

  # This file will turn into an Ecto schema,
  # the struct is temp
end
