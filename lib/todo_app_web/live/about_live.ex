defmodule TodoAppWeb.AboutLive do
  use TodoAppWeb, :live_view

  alias TodoApp.Locales

  @impl true
  def render(assigns) do
    ~H"""
    <h3 class="text-center text-taPurple-light text-xl lg:text-2xl font-normal lg:font-semibold">
      {gettext("About this app")}
    </h3>

    <p class="mt-8 lg:mt-12 text-center text-taLavender font-extralight">
      {gettext("A simple to-do manager so you don't forget your chores")}
    </p>
    """
  end

  @impl true
  def handle_params(_params, uri, socket) do
    %{path: path} = URI.parse(uri)

    {:noreply, socket |> assign(:path, path)}
  end

  @impl true
  def mount(_params, _session, socket) do
    list_locales = Locales.list_locales()

    if list_locales != [] do
      [locale | _] = list_locales
      Gettext.put_locale(TodoAppWeb.Gettext, locale.language)
    end

    {:ok, socket}
  end
end
