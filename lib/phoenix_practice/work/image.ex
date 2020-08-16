defmodule PhoenixPractice.Work.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key false

  embedded_schema do
    field :url,   :string
    field :height, :integer
    field :width,  :integer
  end

  def changeset(image, attrs) do
    image
    |> cast(attrs, [
      :url,
      :height,
      :width,
    ])
    |> validate_required([
      :url,
      :height,
      :width,
    ])
  end
end
