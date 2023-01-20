defmodule UseeKioskWeb.RandomImageController do
  use UseeKioskWeb, :controller

  def random_image() do
    {:ok, images} =
      Application.get_env(:usee_kiosk, :images_path)
      |> File.ls()

    Enum.random(images)
  end

  def index(conn, _params) do
    conn
    |> redirect(to: "/images/#{random_image()}")
  end
end
