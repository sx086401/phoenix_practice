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

  def show(conn, %{"id" => id}) do
    book =
      case Work.get_books([id: id], [:selected_authors]) do
        [book] -> Map.put(book, :authors, Jason.encode!(book.authors))
        _ -> %{}
      end
    render(conn, "show.html", book: book)
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

  def update(conn, %{"id" => id} = params) do
    request = params |> Map.delete(:id) |> convert_to_keyword_list()
    case Work.update_books_by_query([id: id], [set: request]) do
      {1, _} ->
        json(conn, %{})
      _ ->
        json(conn, %{status: 500, description: "Some error had happened."})
    end
    render(conn, "index.html")
  end

  def delete(conn, %{"id" => id}) do
    case Work.delete_books_by_query([id: id]) do
      {1, _} ->
        send_resp(conn, 204, "")
      _ ->
        json(conn, %{status: 500, description: "Some error had happened."})
    end
  end

  defp convert_to_keyword_list(map) do
    Enum.map(map, fn({key, value}) -> {String.to_existing_atom(key), value} end)
  end
end
