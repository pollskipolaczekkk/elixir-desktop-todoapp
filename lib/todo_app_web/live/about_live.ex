defmodule TodoAppWeb.AboutLive do
  use TodoAppWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <h3 class="text-center text-taPurple-light text-xl lg:text-2xl font-normal lg:font-semibold">
      About this app
    </h3>

    <p class="mt-8 lg:mt-12 text-center text-taLavender font-extralight">
      A simple to-do manager so you don't forget your chores
    </p>
    """
  end

  @impl true
  def handle_params(_params, uri, socket) do
    %{path: path} = URI.parse(uri)

    {:noreply, socket |> assign(:path, path)}
  end
end
