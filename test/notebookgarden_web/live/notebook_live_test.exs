defmodule NotebookGardenWeb.NotebookLiveTest do
  use NotebookGardenWeb.ConnCase

  import Phoenix.LiveViewTest
  import NotebookGarden.CodingFixtures

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp create_notebook(_) do
    notebook = notebook_fixture()
    %{notebook: notebook}
  end

  describe "Index" do
    setup [:create_notebook]

    test "lists all notebooks", %{conn: conn, notebook: notebook} do
      {:ok, _index_live, html} = live(conn, Routes.notebook_index_path(conn, :index))

      assert html =~ "Listing Notebooks"
      assert html =~ notebook.title
    end

    test "saves new notebook", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.notebook_index_path(conn, :index))

      assert index_live |> element("a", "New Notebook") |> render_click() =~
               "New Notebook"

      assert_patch(index_live, Routes.notebook_index_path(conn, :new))

      assert index_live
             |> form("#notebook-form", notebook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#notebook-form", notebook: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.notebook_index_path(conn, :index))

      assert html =~ "Notebook created successfully"
      assert html =~ "some title"
    end

    test "updates notebook in listing", %{conn: conn, notebook: notebook} do
      {:ok, index_live, _html} = live(conn, Routes.notebook_index_path(conn, :index))

      assert index_live |> element("#notebook-#{notebook.id} a", "Edit") |> render_click() =~
               "Edit Notebook"

      assert_patch(index_live, Routes.notebook_index_path(conn, :edit, notebook))

      assert index_live
             |> form("#notebook-form", notebook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#notebook-form", notebook: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.notebook_index_path(conn, :index))

      assert html =~ "Notebook updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes notebook in listing", %{conn: conn, notebook: notebook} do
      {:ok, index_live, _html} = live(conn, Routes.notebook_index_path(conn, :index))

      assert index_live |> element("#notebook-#{notebook.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#notebook-#{notebook.id}")
    end
  end

  describe "Show" do
    setup [:create_notebook]

    test "displays notebook", %{conn: conn, notebook: notebook} do
      {:ok, _show_live, html} = live(conn, Routes.notebook_show_path(conn, :show, notebook))

      assert html =~ "Show Notebook"
      assert html =~ notebook.title
    end

    test "updates notebook within modal", %{conn: conn, notebook: notebook} do
      {:ok, show_live, _html} = live(conn, Routes.notebook_show_path(conn, :show, notebook))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Notebook"

      assert_patch(show_live, Routes.notebook_show_path(conn, :edit, notebook))

      assert show_live
             |> form("#notebook-form", notebook: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#notebook-form", notebook: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.notebook_show_path(conn, :show, notebook))

      assert html =~ "Notebook updated successfully"
      assert html =~ "some updated title"
    end
  end
end
