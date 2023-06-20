defmodule MavuUtils.MixProject do
  use Mix.Project

  @version "1.0.1"
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
      name: "MavuUtils",
      source_url: "https://github.com/mavuio/mavu_utils"
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
      {:decimal, ">= 0.0.0"},
      {:ecto, ">= 0.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Simple Useful Utility functions for my other upcoming packages under mavuio/\*"
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/mavuio/mavu_utils"}
    ]
  end
end
