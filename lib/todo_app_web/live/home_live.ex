defmodule TodoAppWeb.HomeLive do
  use TodoAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="mt-20 text-center text-taDark-light text-4xl font-bold">
      Hello from Home Page !!
    </h1>
    """
  end
end
