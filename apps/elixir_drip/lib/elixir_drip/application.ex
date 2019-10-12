defmodule ElixirDrip.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias ElixirDrip.Storage.Supervisors.CacheSupervisor

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(ElixirDrip.Repo, []),
      supervisor(CacheSupervisor, []),
      worker(Registry, [[keys: :unique, name: ElixirDrip.Registry]])
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ElixirDrip.Supervisor)
  end
end
