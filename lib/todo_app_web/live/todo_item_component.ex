defmodule TodoAppWeb.TodoItemComponent do
  use TodoAppWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <li
      phx-click="update"
      phx-value-id={@todo.id}
      class={[
        "flex justify-between items-center my-1 pl-2 bg-taPurple-light rounded-md text-taDark overflow-clip",
        @todo.done && "line-through"
      ]}
    >
      <div class="flex items-center">
        <.icon
          class={"bg-green-800 w-4 h-4 opacity-0 #{@todo.done && "opacity-100"}"}
          name="hero-check"
        />
        <span
          id={"todo-#{@todo.id}"}
          phx-hook="SetTitle"
          data-time={@todo.updated_at}
          data-description={@todo.description}
          data-done={if @todo.done, do: "completed", else: "not completed"}
          class="block cursor-pointer pl-3 pr-6"
        >
          {@todo.title}
        </span>
      </div>
      <button
        title="Delete to-do"
        phx-click="delete"
        phx-value-id={@todo.id}
        data-confirm="Are you sure you want to delete this to-do?"
        class="px-3 py-1 h-full hover:bg-red-500"
      >
        <.icon class="bg-taDark w-4 h-4" name="hero-x-mark" />
      </button>
    </li>
    """
  end
end
