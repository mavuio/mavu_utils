defmodule MavuUtils.MixProject do
  use Mix.Project

  @version "0.1.2"
  def project do
    [
      app: :mavu_utils,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:decimal, ">= 1.0"},
      {:blankable, "~> 1.0"}
    ]
  end
end
