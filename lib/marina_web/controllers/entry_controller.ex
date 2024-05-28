defmodule MarinaWeb.EntryController do
  use MarinaWeb, :controller

  alias Marina.Entries
  alias Marina.Entries.Entry

  @options [Sim: true, Não: false]

  def index(conn, %{"id" => id}) do
    entries = Entries.list_report_entries(id)
    render(conn, "index.html", id: id, entries: entries)
  end

  def new(conn, %{"id" => id}) do
    entry = %Entry{}
    changeset = Entries.change_entry(entry)
    render(conn, "new.html", id: id, entry: entry, changeset: changeset, options: @options)
  end

  def create(conn, %{"id" => id, "entry" => entry}) do
    case Entries.create_entry(entry) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Lançamento criado com sucesso!")
        |> redirect(to: Routes.report_path(conn, :show, entry["report_id"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", id: id, entry: entry, changeset: changeset, options: @options)
    end
  end

  def show(conn, %{"id" => id, "eid" => eid}) do
    entry = Entries.get_entry!(eid)
    render(conn, "show.html", id: id, entry: entry)
  end

  def edit(conn, %{"id" => rid, "eid" => id}) do
    entry = Entries.get_entry!(id)
    changeset = Entries.change_entry(entry)
    render(conn, "edit.html", id: rid, entry: entry, changeset: changeset, options: @options)
  end

  def update(conn, %{"id" => id, "eid" => eid, "entry" => params}) do
    entry = Entries.get_entry!(eid)

    case Entries.update_entry(entry, params) do
      {:ok, _entry} ->
        conn
        |> put_flash(:info, "Lançamento atualizado com sucesso!")
        |> redirect(to: Routes.report_path(conn, :show, id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", id: eid, changeset: changeset, entry: params, options: @options)
    end
  end

  def delete(conn, %{"id" => id, "eid" => eid}) do
    entry = Entries.get_entry!(eid)

    case Entries.delete_entry(entry) do
      {:ok, _entry} ->
        conn
        |> put_flash(:error, "Lançamento deletado com sucesso!")
        |> redirect(to: Routes.report_path(conn, :show, id))

      {:error, %Ecto.Changeset{}} ->
        redirect(conn, to: Routes.report_path(conn, :index, id))
    end
  end
end
