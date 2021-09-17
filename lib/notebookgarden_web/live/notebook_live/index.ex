defmodule NotebookGardenWeb.NotebookLive.Index do
  use NotebookGardenWeb, :live_view

  alias NotebookGarden.Coding
  alias NotebookGarden.Coding.Notebook

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :notebooks, list_notebooks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Notebook")
    |> assign(:notebook, Coding.get_notebook!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Notebook")
    |> assign(:notebook, %Notebook{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Notebooks")
    |> assign(:notebook, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    notebook = Coding.get_notebook!(id)
    {:ok, _} = Coding.delete_notebook(notebook)

    {:noreply, assign(socket, :notebooks, list_notebooks())}
  end

  defp list_notebooks do
    Coding.list_notebooks()
  end
end
