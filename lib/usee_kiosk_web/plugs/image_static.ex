defmodule UseeKioskWeb.Plugs.ImageStatic do
  @moduledoc """
  Serve static images from a runtime config folder.
  """
  @behaviour Plug

  def file_path(path) do
    Path.join(Application.get_env(:usee_kiosk, :images_path), path)
  end

  def init(opts) do
    opts
    |> Keyword.put(:from, "__unconfigured_static_plug")
    |> Plug.Static.init()
  end

  def call(%{request_path: "/images" <> _} = conn, opts) do
    opts =
      opts
      |> Map.put(:from, Application.get_env(:usee_kiosk, :images_path))

    Plug.Static.call(conn, opts)
  end

  def call(conn, _opts), do: conn
end
