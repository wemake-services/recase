defmodule Recase.Mixfile do
  use Mix.Project

  @version "0.8.1"
  @url "https://github.com/wemake-services/recase"

  def project do
    [
      app: :recase,
      version: @version,
      elixir: "~> 1.10",
      deps: deps(),

      # Hex:
      docs: docs(),
      description: description(),
      package: package(),
      source_url: @url,
      homepage_url: @url,
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,

      # Test coverage:
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],

      # Dialyzer:
      dialyzer: [
        plt_add_deps: :apps_direct,
        plt_core_path: "priv/plts",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:excoveralls, "~> 0.18", only: :test},
      {:castore, "~> 1.0", only: :test, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},

      # Documentation:
      {:ex_doc, "~> 0.38.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Convert strings to any case you need."
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [],
        "CONTRIBUTING.md": [title: "Contributing"],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @url,
      source_ref: @version,
      formatters: ["html"]
    ]
  end

  defp package do
    [
      maintainers: ["Nikita Sobolev"],
      licenses: ["MIT"],
      links: %{"GitHub" => @url},
      files: ~w(mix.exs README.md lib),
      exclude_patterns: [".DS_Store"]
    ]
  end
end
