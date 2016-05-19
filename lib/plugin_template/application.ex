defmodule PluginTemplate.Application do
  use Application

  def start(_type, _args) do
    env = Application.get_all_env(:emqttd_elixir_plugin_template)
    PluginTemplate.load(env)

    Task.start_link &noop/0
  end

  def stop(_state) do
    PluginTemplate.unload
  end

  defp noop do
    :timer.sleep 5_000
    noop
  end
end
