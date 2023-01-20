defmodule UseeKioskWeb.PageController do
  use UseeKioskWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", url: url())
  end

  defp url do
    Application.fetch_env!(:usee_kiosk, :url)
  end
end
