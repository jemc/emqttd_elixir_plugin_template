defmodule MQTT.Records do
  defmacro __using__(_opts) do
    quote location: :keep do
      require Record

      [
        mqtt_topic: [
          topic: :undefined,
          flags: :undefined,
        ],
        mqtt_subscription: [
          subid: :undefined,
          topic: :undefined,
          qos: 0
        ],
        mqtt_route: [
          topic: :undefined,
          node: :undefined,
        ],
        mqtt_client: [
          client_id: :undefined,
          client_pid: :undefined,
          username: :undefined,
          peername: :undefined,
          clean_sess: :undefined,
          proto_ver: :undefined,
          keepalive: 0,
          will_topic: :undefined,
          ws_initial_headers: :undefined,
          connected_at: :undefined,
        ],
        mqtt_session: [
          client_id: :undefined,
          sess_pid: :undefined,
          persistent: :undefined,
        ],
        mqtt_message: [
          msgid: :undefined,
          pktid: :undefined,
          topic: :undefined,
          from: :undefined,
          sender: :undefined,
          qos: 0,
          flags: [],
          retain: false,
          dup: false,
          sys: false,
          payload: :undefined,
          timestamp: :undefined,
        ],
        mqtt_alarm: [
          id: :undefined,
          severity: :undefined,
          title: :undefined,
          summary: :undefined,
          timestamp: :undefined,
        ],
        mqtt_plugin: [
          name: :undefined,
          version: :undefined,
          descr: :undefined,
          config: :undefined,
          active: false,
        ],
        mqtt_cli: [
          name: :undefined,
          action: :undefined,
          args: [],
          opts: [],
          usage: :undefined,
          descr: :undefined
        ]
      ] |> Enum.each(fn({name, kv}) -> Record.defrecord(name, kv) end)

    end
  end
end
