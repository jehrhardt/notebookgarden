defmodule NotebookGardenWeb.NotebookLive.Show do
  use NotebookGardenWeb, :live_view

  alias NotebookGarden.Coding

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:notebook, Coding.get_notebook!(id))}
  end

  defp page_title(:show), do: "Show Notebook"
  defp page_title(:edit), do: "Edit Notebook"
end
