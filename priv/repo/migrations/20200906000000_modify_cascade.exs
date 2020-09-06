defmodule PhoenixPractice.Migrations.ModifyCascade do
  use Ecto.Migration

  def change do
    drop constraint(:book_authors, :book_authors_book_id_fkey)

    alter table(:book_authors) do
      modify :book_id, references("books", on_delete: :delete_all), null: false
    end
  end
end
