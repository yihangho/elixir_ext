defmodule Ext.MixProject do
  use Mix.Project

  def project do
    [
      app: :ext,
      version: "0.1.0",
      elixir: "~> 1.16",
      deps: deps()
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
end
