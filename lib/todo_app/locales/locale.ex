defmodule TodoApp.Locales.Locale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locales" do
    field :language, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(locale, attrs) do
    locale
    |> cast(attrs, [:language])
    |> validate_required([:language])
  end
end
