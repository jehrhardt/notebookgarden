defmodule NotebookGarden.Coding.Notebook do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "notebooks" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(notebook, attrs) do
    notebook
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
