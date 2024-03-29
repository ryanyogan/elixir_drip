defmodule ElixirDrip.Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.3", only: [:test, :dev], runtime: false}
    ]
  end

  defp aliases do
    [
      lint: ["format", "credo"]
    ]
  end
end
