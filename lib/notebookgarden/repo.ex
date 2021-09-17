defmodule NotebookGarden.Repo do
  use Ecto.Repo,
    otp_app: :notebookgarden,
    adapter: Ecto.Adapters.Postgres
end
