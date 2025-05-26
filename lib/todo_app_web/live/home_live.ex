defmodule TodoAppWeb.HomeLive do
  use TodoAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="bg-taLavender rounded-lg w-full h-96 mx-auto"></div>
    """
  end

  def handle_params(_params, uri, socket) do
    %{path: path} = URI.parse(uri)

    {:noreply, socket |> assign(:path, path)}
  end
end
