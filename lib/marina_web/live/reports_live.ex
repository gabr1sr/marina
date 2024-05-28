defmodule MarinaWeb.ReportsLive do
  use MarinaWeb, :live_view

  alias MarinaWeb.ReportView
  alias Marina.Reports

  @update_delay 10000

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, @update_delay)
    {:ok, assign_new(socket, :reports, &Reports.list_report/0)}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(ReportView, "index.html", assigns)
  end

  @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, @update_delay)
    {:ok, assign(socket, :reports, Reports.list_report())}
  end

  @impl true
  def handle_info(_info, socket) do
    {:no_reply, socket}
  end
end
