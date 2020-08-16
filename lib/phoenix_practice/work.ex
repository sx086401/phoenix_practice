defmodule PhoenixPractice.Work do
  import Ecto.Query

  alias PhoenixPractice.{EctoQueryMaker, Repo}
  alias PhoenixPractice.Work.{Author, Book}

  def get_books(filters, opts \\ []) do
    Book
    |> EctoQueryMaker.apply(filters, opts)
    |> Repo.all()
  end

  def count_books(filters, opts \\ []) do
    Book
    |> EctoQueryMaker.apply(filters, opts)
    |> select(count())
    |> Repo.one()
  end

  def create_books(params \\ %{}) do
    %Book{}
    |> Book.changeset(params)
    |> Repo.insert!()
  end

  # updates is a keyword list. (e.g. [set: [title: "new_title"]])
  def update_books_by_query(filters, updates, opts \\ []) do
    Book
    |> EctoQueryMaker.apply(filters, opts)
    |> Repo.update_all(updates)
  end

  def delete_books_by_query(filters, opts \\ []) do
    Book
    |> EctoQueryMaker.apply(filters, opts)
    |> Repo.delete!()
  end

  def get_authors(filters, opts \\ []) do
    Author
    |> EctoQueryMaker.apply(filters, opts)
    |> Repo.all()
  end

  def count_authors(filters, opts \\ []) do
    Author
    |> EctoQueryMaker.apply(filters, opts)
    |> select(count())
    |> Repo.one()
  end

  def create_authors(params \\ %{}) do
    %Author{}
    |> Book.changeset(params)
    |> Repo.insert!()
  end

  def update_authors_by_query(filters, updates, opts \\ []) do
    Author
    |> EctoQueryMaker.apply(filters, opts)
    |> Repo.update_all(updates)
  end

  def delete_authors_by_query(filters, opts \\ []) do
    Author
    |> EctoQueryMaker.apply(filters, opts)
    |> Repo.delete!()
  end
end
