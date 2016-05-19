defmodule PluginTemplate.Mixfile do
  use Mix.Project

  def project do
    [
      app: :emqttd_elixir_plugin_template,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [
      applications: [
        :logger
      ],
      mod: {PluginTemplate.Application, []},
      env: [],
    ]
  end

  defp deps do
    [
      exrm: "~> 1.0.2"
    ]
  end
end
