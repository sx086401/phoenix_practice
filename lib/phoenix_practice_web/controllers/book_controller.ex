defmodule PhoenixPracticeWeb.BookController do
  use PhoenixPracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => _id}) do
    render(conn, "index.html")
  end

  def create(conn, %{"book" => _book_params}) do
    render(conn, "index.html")
  end

  def update(conn, %{"book" => _book_params}) do
    render(conn, "index.html")
  end

  def delete(conn, %{"id" => _id}) do
    render(conn, "index.html")
  end
end
