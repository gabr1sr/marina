defmodule MarinaWeb.ReportController do
  use MarinaWeb, :controller

  alias Marina.Entries
  alias Marina.Reports
  alias Marina.Reports.Report

  import Phoenix.LiveView.Controller

  def index(conn, _params) do
    conn
    |> assign(:reports, Reports.list_report())
    |> live_render(MarinaWeb.ReportsLive, session: %{})
  end

  def new(conn, _params) do
    report = %Report{}
    changeset = Reports.change_report(report)
    render(conn, "new.html", report: report, changeset: changeset)
  end

  def create(conn, %{"report" => report}) do
    case Reports.create_report(report) do
      {:ok, _report} ->
        conn
        |> put_flash(:info, "Relatório criado com sucesso!")
        |> redirect(to: Routes.report_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    report = Reports.get_report!(id)
    entries = Entries.list_report_entries(id)
    render(conn, "show.html", report: report, entries: entries)
  end

  def edit(conn, %{"id" => id}) do
    report = Reports.get_report!(id)
    changeset = Reports.change_report(report)
    render(conn, "edit.html", report: report, changeset: changeset)
  end

  def update(conn, %{"id" => id, "report" => params}) do
    report = Reports.get_report!(id)

    case Reports.update_report(report, params) do
      {:ok, _report} ->
        conn
        |> put_flash(:info, "Relatório atualizado com sucesso")
        |> redirect(to: Routes.report_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", report: report, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    report = Reports.get_report!(id)

    Enum.each(Entries.list_report_entries(report.id), fn entry ->
      case Entries.delete_entry(entry) do
        {:ok, _entry} -> true
        {:error, _changeset} -> false
      end
    end)
    |> IO.inspect()

    case Reports.delete_report(report) do
      {:ok, _report} ->
        conn
        |> put_flash(:error, "Relatório deletado com sucesso!")
        |> redirect(to: Routes.report_path(conn, :index))

      {:error, %Ecto.Changeset{}} ->
        redirect(conn, to: Routes.report_path(conn, :index))
    end
  end
end
