defmodule PhoenixPractice.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :category,         :integer,      null: false
      add :title,            :string,       null: false
      add :description,      :string
      add :publish_begin_at, :utc_datetime, null: false
      add :publish_end_at,   :utc_datetime, null: false
      add :search_text,      :string,       default: ""
      add :volume,           :string,       null: false
      add :image,            :map,          default: %{}

      timestamps()
    end

    create index(:books, :category)
  end
end
