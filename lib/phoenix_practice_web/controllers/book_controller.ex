defmodule PhoenixPracticeWeb.BookController do
  use PhoenixPracticeWeb, :controller

  alias PhoenixPractice.Work

  def index(conn, _params) do
    books =
      Work.get_books([], [preload: [:authors]])
      |> Enum.map(fn work ->
        %{
          id: work.id,
          title: work.title,
          description: work.description,
          publish_begin_at: work.publish_begin_at,
          publish_end_at: work.publish_end_at,
          search_text: work.search_text,
          volume: work.volume,
          authors: Enum.map(work.authors, & &1.name) |> Enum.join(","),
        }
      end)
    render(conn, "index.html", books: books)
  end

  def show(conn, %{"id" => _id}) do
    render(conn, "index.html")
  end

  # Example request body: %{category: :comic, book_authors: [%{author_id: 1}, ...]}
  def create(conn, book_params) do
    case Work.create_books(book_params) do
      {:ok, _} ->
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
