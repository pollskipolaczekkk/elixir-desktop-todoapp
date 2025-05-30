defmodule TodoAppWeb.HomeLive do
  use TodoAppWeb, :live_view

  alias TodoApp.{Todos, Todos.Todo, Locales}
  alias TodoAppWeb.TodoItemComponent
  alias Desktop.{OS, Window}

  @impl true
  def render(assigns) do
    ~H"""
    <div
      id="keyboard-events"
      class="bg-slate-800 rounded-lg w-full mx-auto p-4"
      phx-hook="DetectKeyboardEvents"
    >
      <.simple_form
        id="todo-form"
        for={@form}
        phx-submit="save"
        phx-change="validate"
        phx-trigger-action={@trigger_submit}
        class="bg-transparent"
      >
        <.error :if={@check_errors}>
          Oops, something went wrong! Please check the errors below.
        </.error>
        <.input
          id="title-input"
          field={@form[:title]}
          label={gettext("Title")}
          class="bg-zinc-900 text-xs text-white font-extralight rounded-md w-full focus:border focus:border-taLavender focus:outline-none focus:ring-0"
        />
        <.input
          field={@form[:description]}
          type="textarea"
          label={gettext("Description")}
          class="resize-none bg-zinc-900 text-xs text-white font-extralight rounded-md w-full focus:border focus:border-taLavender focus:outline-none focus:ring-0 -mb-1.5"
        />
        <:actions>
          <div class="flex justify-end w-full">
            <.button class="!bg-taPurple border border-white hover:!bg-taPurple-dark hover:!text-taDark-light hover:!border-taDark-light flex gap-2 items-center !px-2 !py-1">
              <img src="/images/save_icon.svg" class="w-[22px]" alt="Save Icon" /> {gettext("Save")}
            </.button>
          </div>
        </:actions>
      </.simple_form>

      <div
        :if={length(@todos) != 0}
        class="bg-taPurple-dark rounded-md mx-auto mt-4 px-2 py-1 text-white max-h-[152px] overflow-y-auto"
      >
        <ul :for={todo <- @todos}>
          <.live_component module={TodoItemComponent} id={todo.id} todo={todo} />
        </ul>
      </div>

      <p :if={length(@todos) == 0} class="mt-6 text-taLavender font-semibold text-lg text-center">
        {gettext("Add some to-dos")} 😀
      </p>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    changeset = Todos.change_todo(%Todo{})
    todos = Todos.list_todos()

    case Locales.list_locales() do
      [] -> Locales.create_locale(%{"language" => "en"})
      [locale | _] -> Gettext.put_locale(TodoAppWeb.Gettext, locale.language)
    end

    socket =
      socket
      |> assign(trigger_submit: false, check_errors: false, todos: todos)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  @impl true
  def handle_params(_params, uri, socket) do
    %{path: path} = URI.parse(uri)

    {:noreply, socket |> assign(:path, path)}
  end

  @impl true
  def handle_event("validate", %{"todo" => todo_params}, socket) do
    changeset =
      %Todo{}
      |> Todos.change_todo(todo_params)

    # IO.inspect(changeset)

    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  @impl true
  def handle_event("save", %{"todo" => params}, socket) do
    # IO.inspect(params)
    case Todos.create_todo(params) do
      {:ok, _todo} ->
        changeset = Todos.change_todo(%Todo{})
        socket = socket |> assign(:form, to_form(changeset))
        {:noreply, push_navigate(socket, to: ~p"/")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    case Todos.delete_todo(id) do
      {:ok, _todo} ->
        {:noreply, push_navigate(socket, to: ~p"/")}

      {:error, :not_found} ->
        socket =
          put_flash(
            socket,
            :error,
            gettext("An error occurred while trying to delete the to-do")
          )

        {:noreply, push_navigate(socket, to: ~p"/")}
    end
  end

  @impl true
  def handle_event("update", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    attrs = %{"done" => !todo.done}

    Todos.update_todo(todo, attrs)

    {:noreply, push_navigate(socket, to: ~p"/")}
  end

  @impl true
  def handle_event("quit", _params, socket) do
    Window.quit()

    {:noreply, socket}
  end

  @impl true
  def handle_event("browser", _params, socket) do
    Window.prepare_url(TodoAppWeb.Endpoint.url())
    |> OS.launch_default_browser()

    {:noreply, socket}
  end

  @impl true
  def handle_event("observer", _params, socket) do
    :observer.start()

    {:noreply, socket}
  end

  @impl true
  def handle_event("spanish", _params, socket) do
    locale = Locales.get_locale!(1)
    Locales.update_locale(locale, %{"language" => "es_ES"})

    Gettext.put_locale("es_ES")

    {:noreply, push_navigate(socket, to: ~p"/")}
  end

  @impl true
  def handle_event("english", _params, socket) do
    locale = Locales.get_locale!(1)
    Locales.update_locale(locale, %{"language" => "en"})

    Gettext.put_locale("en")

    {:noreply, push_navigate(socket, to: ~p"/")}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "todo")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end

# REFERENCES:
# trigger_submit:
# https://hexdocs.pm/phoenix_live_view/form-bindings.html#submitting-the-form-action-over-http
#
# temporary_assigns:
# https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#c:mount/3
