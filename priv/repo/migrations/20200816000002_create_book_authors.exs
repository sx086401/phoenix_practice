defmodule PhoenixPractice.Migrations.CreateBookAuthors do
  use Ecto.Migration

  def change do
    create table(:book_authors) do
      add :author_id, references("authors"), null: false
      add :book_id,   references("books"), null: false

      timestamps()
    end

    create unique_index(:book_authors, [:author_id, :book_id], name: :author_id_book_id_uniq)
  end
end
