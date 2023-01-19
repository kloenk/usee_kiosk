defmodule UseeKioskWeb.PageController do
  use UseeKioskWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
