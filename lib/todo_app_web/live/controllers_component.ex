defmodule TodoAppWeb.ControllersComponent do
  use TodoAppWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="absolute top-1 left-1">
      <button
        title="Shortcut: Ctrl+Shift+Q"
        class="bg-taLavender-dark px-1.5 py-0.5 text-white text-xs font-extralight rounded-lg hover:scale-105 shadow-[0px_4px_6px_0px_rgba(0,_0,_0,_0.8)]"
        phx-click="quit"
      >
        {gettext("Quit")}
      </button>
      <button
        title="Shortcut: Ctrl+Shift+B"
        class="bg-taLavender-dark px-1.5 py-0.5 text-white text-xs font-extralight rounded-lg hover:scale-105 shadow-[0px_4px_6px_0px_rgba(0,_0,_0,_0.8)]"
        phx-click="browser"
      >
        {gettext("Browser")}
      </button>
      <button
        title="Shortcut: Ctrl+Shift+O"
        class="bg-taLavender-dark px-1.5 py-0.5 text-white text-xs font-extralight rounded-lg hover:scale-105 shadow-[0px_4px_6px_0px_rgba(0,_0,_0,_0.8)]"
        phx-click="observer"
      >
        {gettext("Observer")}
      </button>
    </div>
    """
  end
end
