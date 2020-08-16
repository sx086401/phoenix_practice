defmodule PhoenixPractice.Work.BookAuthor do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixPractice.Work.{Author, Book}

  @timestamps_opts [type: :utc_datetime]

  schema "book_authors" do
    belongs_to :author, Author
    belongs_to :book,   Book

    timestamps()
  end

  def changeset(book_author, attrs) do
    book_author
    |> cast(attrs, [
      :author_id,
      :book_id,
    ])
    |> validate_required([
      :author_id,
      :book_id,
    ])
    |> foreign_key_constraint(:author_id)
    |> foreign_key_constraint(:book_id)
  end
end
