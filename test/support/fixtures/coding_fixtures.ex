defmodule NotebookGarden.CodingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NotebookGarden.Coding` context.
  """

  @doc """
  Generate a notebook.
  """
  def notebook_fixture(attrs \\ %{}) do
    {:ok, notebook} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> NotebookGarden.Coding.create_notebook()

    notebook
  end
end
