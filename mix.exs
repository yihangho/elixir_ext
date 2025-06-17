defmodule Ext.MixProject do
  use Mix.Project

  def project do
    [
      app: :ext,
      version: "1.4.0",
      elixir: "~> 1.16",
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/yihangho/elixir_ext",
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.36", only: :dev, runtime: false},
      {:mimic, "~> 1.11", only: :test},
    ]
  end

  defp description do
    "An extension to the Elixir standard library"
  end

  defp package do
    [
      name: "ext",
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/yihangho/elixir_ext",
      },
    ]
  end
end
