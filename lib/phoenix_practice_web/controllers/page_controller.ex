defmodule PhoenixPracticeWeb.PageController do
  use PhoenixPracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
