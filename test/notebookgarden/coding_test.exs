defmodule NotebookGarden.CodingTest do
  use NotebookGarden.DataCase

  alias NotebookGarden.Coding

  describe "notebooks" do
    alias NotebookGarden.Coding.Notebook

    import NotebookGarden.CodingFixtures

    @invalid_attrs %{title: nil}

    test "list_notebooks/0 returns all notebooks" do
      notebook = notebook_fixture()
      assert Coding.list_notebooks() == [notebook]
    end

    test "get_notebook!/1 returns the notebook with given id" do
      notebook = notebook_fixture()
      assert Coding.get_notebook!(notebook.id) == notebook
    end

    test "create_notebook/1 with valid data creates a notebook" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Notebook{} = notebook} = Coding.create_notebook(valid_attrs)
      assert notebook.title == "some title"
    end

    test "create_notebook/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Coding.create_notebook(@invalid_attrs)
    end

    test "update_notebook/2 with valid data updates the notebook" do
      notebook = notebook_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Notebook{} = notebook} = Coding.update_notebook(notebook, update_attrs)
      assert notebook.title == "some updated title"
    end

    test "update_notebook/2 with invalid data returns error changeset" do
      notebook = notebook_fixture()
      assert {:error, %Ecto.Changeset{}} = Coding.update_notebook(notebook, @invalid_attrs)
      assert notebook == Coding.get_notebook!(notebook.id)
    end

    test "delete_notebook/1 deletes the notebook" do
      notebook = notebook_fixture()
      assert {:ok, %Notebook{}} = Coding.delete_notebook(notebook)
      assert_raise Ecto.NoResultsError, fn -> Coding.get_notebook!(notebook.id) end
    end

    test "change_notebook/1 returns a notebook changeset" do
      notebook = notebook_fixture()
      assert %Ecto.Changeset{} = Coding.change_notebook(notebook)
    end
  end
end
