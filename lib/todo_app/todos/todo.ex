defmodule TodoApp.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :done, :boolean, default: false
    field :description, :string
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @min_chars 3
  @max_chars 40

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description, :done])
    |> validate_required([:title, :description, :done])
    |> validate_length(:title, min: @min_chars, max: @max_chars)
  end
end

# COMMAND:
# mix phx.gen.context Todos Todo todos title:string description:text done:boolean

# REFERENCES:
# https://elixirforum.com/t/defining-ecto-schemas-postgres-to-use-not-null-in-column-definitions/14696/3
