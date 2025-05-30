defmodule TodoApp.LocalesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodoApp.Locales` context.
  """

  @doc """
  Generate a locale.
  """
  def locale_fixture(attrs \\ %{}) do
    {:ok, locale} =
      attrs
      |> Enum.into(%{
        language: "some language"
      })
      |> TodoApp.Locales.create_locale()

    locale
  end
end
