defmodule MavuUtils.MixProject do
  use Mix.Project

  @version "0.1.4"
  def project do
    [
      app: :mavu_utils,
      version: @version,
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Postgrex",
      source_url: "https://github.com/mavuio/mavu_utils"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Simple Useful Utility functions for my other upcoming packages under mavuio/\*"
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:decimal, ">= 1.0.0"},
      {:blankable, "~> 1.0"}
    ]
  end

  defp package() do
    [
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/mavuio/mavu_utils"}
    ]
  end
end
