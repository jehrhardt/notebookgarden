defmodule NotebookGardenWeb.PageController do
  use NotebookGardenWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
