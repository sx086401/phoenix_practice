defmodule PhoenixPractice.Work.Author do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "authors" do
    field :name,        :string
    field :search_text, :string, default: ""

    timestamps()
  end

  def changeset(author, attrs) do
    author
    |> cast(attrs, [
      :name,
      :search_text,
    ])
    |> validate_required([
      :name,
      :search_text,
    ])
  end
end
