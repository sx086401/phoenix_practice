defmodule PhoenixPractice.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name,        :string
      add :search_text, :string, default: ""

      timestamps()
    end
  end
end
