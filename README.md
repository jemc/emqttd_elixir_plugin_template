This is an Elixir template plugin for the [emqttd](https://github.com/emqtt/emqttd) project, based on [the original Erlang template](https://github.com/emqtt/emqttd_plugin_template).

## Installation

```bash
# Clone the emqttd repo.
git clone https://github.com/emqtt/emqttd.git && cd emqttd

# Clone this repo into the emqttd/plugins directory.
git clone https://github.com/jemc/emqttd_elixir_plugin_template.git plugins/emqttd_elixir_plugin_template

# Build the Elixir plugin as a release.
make -C plugins/emqttd_elixir_plugin_template

# Build emqttd and its other plugins.
make dist
```
