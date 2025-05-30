defmodule TodoApp.Repo.Migrations.CreateLocales do
  use Ecto.Migration

  def change do
    create table(:locales) do
      add :language, :string

      timestamps(type: :utc_datetime)
    end
  end
end
