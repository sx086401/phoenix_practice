defmodule PhoenixPracticeWeb.BookController do
  use PhoenixPracticeWeb, :controller

  alias PhoenixPractice.Work

  def index(conn, _params) do
    books = Work.get_books([])
    render(conn, "index.html", books: books)
  end

  def show(conn, %{"id" => _id}) do
    render(conn, "index.html")
  end

  # Example request body: %{category: :comic, book_authors: [%{author_id: 1}, ...]}
  def create(conn, book_params) do
    case Work.create_books(book_params) do
      {:ok, res} ->
        send_resp(conn, 201, "Succeeded")
      {:error, _} ->
        json(conn, %{status: 500, description: "Some error had happened."})
    end
  end

  def update(conn, %{"book" => _book_params}) do
    render(conn, "index.html")
  end

  def delete(conn, %{"id" => _id}) do
    render(conn, "index.html")
  end
end
