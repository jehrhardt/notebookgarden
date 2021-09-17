defmodule NotebookGardenWeb.NotebookLive.FormComponent do
  use NotebookGardenWeb, :live_component

  alias NotebookGarden.Coding

  @impl true
  def update(%{notebook: notebook} = assigns, socket) do
    changeset = Coding.change_notebook(notebook)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"notebook" => notebook_params}, socket) do
    changeset =
      socket.assigns.notebook
      |> Coding.change_notebook(notebook_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"notebook" => notebook_params}, socket) do
    save_notebook(socket, socket.assigns.action, notebook_params)
  end

  defp save_notebook(socket, :edit, notebook_params) do
    case Coding.update_notebook(socket.assigns.notebook, notebook_params) do
      {:ok, _notebook} ->
        {:noreply,
         socket
         |> put_flash(:info, "Notebook updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_notebook(socket, :new, notebook_params) do
    case Coding.create_notebook(notebook_params) do
      {:ok, _notebook} ->
        {:noreply,
         socket
         |> put_flash(:info, "Notebook created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
