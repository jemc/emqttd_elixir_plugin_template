defmodule PluginTemplate do
  require Logger
  use MQTT.Records

  def load(env) do
    Logger.info "Loaded plugin #{__MODULE__}"

    :emqttd.hook :'client.connected',       &on_client_connected/3,       [env]
    :emqttd.hook :'client.disconnected',    &on_client_disconnected/3,    [env]
    :emqttd.hook :'client.subscribe',       &on_client_subscribe/3,       [env]
    :emqttd.hook :'client.subscribe.after', &on_client_subscribe_after/3, [env]
    :emqttd.hook :'client.unsubscribe',     &on_client_unsubscribe/3,     [env]
    :emqttd.hook :'message.publish',        &on_message_publish/2,        [env]
    :emqttd.hook :'message.delivered',      &on_message_delivered/3,      [env]
    :emqttd.hook :'message.acked',          &on_message_acked/3,          [env]
  end

  def unload do
    :emqttd.unhook :'client.connected',       &on_client_connected/3
    :emqttd.unhook :'client.disconnected',    &on_client_disconnected/3
    :emqttd.unhook :'client.subscribe',       &on_client_subscribe/3
    :emqttd.unhook :'client.subscribe.after', &on_client_subscribe_after/3
    :emqttd.unhook :'client.unsubscribe',     &on_client_unsubscribe/3
    :emqttd.unhook :'message.publish',        &on_message_publish/2
    :emqttd.unhook :'message.delivered',      &on_message_delivered/3
    :emqttd.unhook :'message.acked',          &on_message_acked/3

    Logger.info "Unloaded plugin #{__MODULE__}"
  end

  def on_client_connected(_conn_ack, client, _env) do
    Logger.info "#{mqtt_client(client, :client_id)} is connecting"

    {:ok, client}
  end

  def on_client_disconnected(reason, client_id, _env) do
    Logger.info "#{client_id} disconnected for reason: #{inspect reason}"

    :ok
  end

  def on_client_subscribe(client_id, topics, _env) do
    Logger.info "#{client_id} will subscribe to: #{inspect topics}"

    {:ok, topics}
  end

  def on_client_subscribe_after(client_id, topics, _env) do
    Logger.info "#{client_id} subscribed to: #{inspect topics}"

    {:ok, topics}
  end

  def on_client_unsubscribe(client_id, topics, _env) do
    Logger.info "#{client_id} will unsubscribe from: #{inspect topics}"

    {:ok, topics}
  end

  def on_message_publish(mqtt_message(topic: "$SYS" <> _), _env) do
    # Ignore - don't log system messages.

    :ok
  end

  def on_message_publish(message, _env) do
    pair = {mqtt_message(message, :topic), mqtt_message(message, :payload)}
    Logger.info "#{inspect pair} is being published"

    {:ok, message}
  end

  def on_message_delivered(client_id, message, _env) do
    pair = {mqtt_message(message, :topic), mqtt_message(message, :payload)}
    Logger.info "#{inspect pair} is being delivered to #{client_id}"

    {:ok, message}
  end

  def on_message_acked(client_id, message, _env) do
    pair = {mqtt_message(message, :topic), mqtt_message(message, :payload)}
    Logger.info "#{inspect pair} was acked by #{client_id}"

    {:ok, message}
  end
end
