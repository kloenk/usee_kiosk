defmodule UseeKiosk.Release do
  @moduledoc """
  This module is used to configure the release.
  """
  @behaviour Config.Provider

  @impl Config.Provider
  def init(opts) do
    opts
  end

  @impl Config.Provider
  def load(config, opts) do
    config_path =
      opts[:config_path] || System.get_env("USEE_CONFIF_PATH") || "/etc/usee/kiosk.exs"

    if File.exists?(config_path) do
      runtime_config = Config.Reader.read!(config_path)

      config
      |> Config.Reader.merge(usee_kiosk: [config_path: config_path])
      |> Config.Reader.merge(runtime_config)
    else
      [
        IO.ANSI.red(),
        IO.ANSI.bright(),
        "!!! Config file not found: #{config_path} !!",
        IO.ANSI.reset()
      ]
      |> IO.puts()

      config
    end
  end
end
