defmodule PhoenixPractice.Work.BookQuery do
  @behaviour PhoenixPractice.EctoQueryMaker

  import Ecto.Query

  alias PhoenixPractice.Work.Author

  @impl true
  def apply_option(:selected_authors, query) do
    select_query =
      Author
      |> select([a], map(a, [:id, :name, :search_text, :inserted_at, :updated_at]))
    query
    |> join(:left, [b], a in assoc(b, :authors))
    |> preload([authors: ^select_query])
  end

  def apply_option(_, query), do: query
end
