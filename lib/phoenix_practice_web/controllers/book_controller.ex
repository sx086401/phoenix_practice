defmodule PhoenixPracticeWeb.BookController do
  use PhoenixPracticeWeb, :controller

  alias PhoenixPractice.Work

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => _id}) do
    render(conn, "index.html")
  end

  # Example request body: %{category: :comic, title: "some_title", book_authors: [%{author_id: 1}]}
  def create(conn, book_params) do
    res = Work.create_books(book_params)
    json(conn, res)
  end

  def update(conn, %{"book" => _book_params}) do
    render(conn, "index.html")
  end

  def delete(conn, %{"id" => _id}) do
    render(conn, "index.html")
  end
end
