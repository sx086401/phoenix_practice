defmodule PhoenixPractice.Work.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixPractice.Work.{BookAuthor, Image}

  @timestamps_opts [type: :utc_datetime]

  schema "books" do
    field :category,            CategoryEnum
    field :title,               :string
    field :description,         :string, default: ""
    field :publish_begin_at,    :utc_datetime
    field :publish_end_at,      :utc_datetime
    field :search_text,         :string
    field :volume,              :integer

    embeds_one :image,          Image, on_replace: :delete

    has_many :book_authors,     BookAuthor, on_replace: :delete
    has_many :authors, through: [:book_authors, :author]

    timestamps()
  end

  def changeset(book, attrs) do
    book
    |> cast(attrs, [
      :category,
      :title,
      :description,
      :publish_begin_at,
      :publish_end_at,
      :search_text,
      :volume,
    ])
    |> cast_embed(:image, with: &Image.changeset/2)
    |> cast_assoc(:book_authors, &BookAuthor.changeset/2)
  end
end
