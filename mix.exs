defmodule ApiBanking.MixProject do
  use Mix.Project

  def project do
    [
      app: :api_banking,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ApiBanking.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.0"},
      {:ecto, "~> 3.0.7"},
      {:postgrex, "~> 0.14.1"}
    ]
  end
end
