defmodule NotebookGardenWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `NotebookGardenWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal NotebookGardenWeb.NotebookLive.FormComponent,
        id: @notebook.id || :new,
        action: @live_action,
        notebook: @notebook,
        return_to: Routes.notebook_index_path(@socket, :index) %>
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(NotebookGardenWeb.ModalComponent, modal_opts)
  end
end
