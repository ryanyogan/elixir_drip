defmodule ElixirDrip.Ecto.Ksuid do
  @moduledoc """
  A module implementing ksuid as an ecto type.
  To enable ksuid as the primary key type for ecto schemas add this annotation
  on top of the schema definition:

      @primary_key {:id, ...Ecto.Ksuid, autogenerate: true}
      schema "my_schema" do
        (...)
      end

  To use it as the type of any other schema field do the following:

      schema "my_schema" do
        (...)
        field :my_ksuid_field, ...Ecto.Ksuid
        (...)
      end

  More info about ksuid may be found [here](https://segment.com/blog/a-brief-history-of-the-uuid/).
  The elixir library used can be found [here](https://github.com/girishramnani/elixir-ksuid).
  """

  def type, do: :string

  def cast(ksuid) when is_binary(ksuid), do: {:ok, ksuid}
  def cast(_), do: :error

  @doc """
  Same as `cast/1` but raises `Ecto.CastError` on invalid arguments.
  """
  def cast!(value) do
    case cast(value) do
      {:ok, ksuid} -> ksuid
      :error -> raise Ecto.CastError, type: __MODULE__, value: value
    end
  end

  def load(ksuid), do: {:ok, ksuid}

  def dump(binary) when is_binary(binary), do: {:ok, binary}
  def dump(_), do: :error

  # Callback invoked by autogenerate fields - this is all that really matters
  # just passing around the binary otherwise.
  @doc false
  def autogenerate, do: Ksuid.generate()
end
