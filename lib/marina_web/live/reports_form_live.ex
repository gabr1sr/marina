defmodule MarinaWeb.ReportsFormLive do
  use MarinaWeb, :live_view

  require Logger

  alias MarinaWeb.ReportView
  alias Marina.Reports

  @impl true
  def mount(_params, %{"action" => action, "changeset" => changeset, "report" => report}, socket) do
    reports = Reports.list_report()

    {:ok,
     assign(
       socket,
       action: action,
       changeset: changeset,
       reports_backup: reports,
       reports: reports,
       vessels: get_vessels(reports) |> normalize(),
       models: get_models(reports) |> normalize(),
       owners: get_owners(reports) |> normalize(),
       feets: get_feets(reports) |> normalize(),
       report: report
     )}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(ReportView, "form.html", assigns)
  end

  @impl true
  def handle_event(
        "update",
        %{
          "report" => %{"vessel" => vessel, "model" => model, "owner" => owner, "feets" => feets}
        },
        socket
      ) do
    reports = socket.assigns.reports_backup

    {:noreply,
     assign(
       socket,
       reports: reports,
       vessels: reports |> filter_vessel(vessel) |> get_vessels() |> normalize(),
       models: reports |> filter_model(model) |> get_models() |> normalize(),
       owners: reports |> filter_owner(owner) |> get_owners() |> normalize(),
       feets: reports |> filter_feets(feets) |> get_feets() |> normalize(),
       report: %{
         vessel: vessel,
         model: model,
         owner: owner,
         feets: feets
       }
     )}
  end

  @impl true
  def handle_info(_info, socket) do
    {:no_reply, socket}
  end

  defp vessel_exists?("", _schemas), do: true

  defp vessel_exists?(vessel, schemas) do
    schemas
    |> get_vessels()
    |> Enum.any?(&String.starts_with?(&1, vessel))
  end

  defp model_exists?("", _schemas), do: true

  defp model_exists?(model, schemas) do
    schemas
    |> get_models()
    |> Enum.any?(&String.starts_with?(&1, model))
  end

  defp owner_exists?("", _schemas), do: true

  defp owner_exists?(owner, schemas) do
    schemas
    |> get_owners()
    |> Enum.any?(&String.starts_with?(&1, owner))
  end

  defp feets_exists?("", _schemas), do: true

  defp feets_exists?(feets, schemas) do
    schemas
    |> get_feets()
    |> Enum.any?(&String.starts_with?(&1, feets))
  end

  defp filter_vessel(schemas, vessel) do
    Enum.flat_map(schemas, fn schema ->
      if String.starts_with?(schema.vessel, vessel) do
        [schema]
      else
        []
      end
    end)
  end

  defp filter_model(schemas, model) do
    Enum.flat_map(schemas, fn schema ->
      if String.starts_with?(schema.model, model) do
        [schema]
      else
        []
      end
    end)
  end

  defp filter_owner(schemas, owner) do
    Enum.flat_map(schemas, fn schema ->
      if String.starts_with?(schema.owner, owner) do
        [schema]
      else
        []
      end
    end)
  end

  defp filter_feets(schemas, feets) do
    Enum.flat_map(schemas, fn schema ->
      if String.starts_with?(schema.feets, feets) do
        [schema]
      else
        []
      end
    end)
  end

  defp get_vessels([]), do: []

  defp get_vessels(schemas) do
    Stream.map(schemas, & &1.vessel) |> Stream.uniq()
  end

  defp get_models([]), do: []

  defp get_models(schemas) do
    Stream.map(schemas, & &1.model) |> Stream.uniq()
  end

  defp get_owners([]), do: []

  defp get_owners(schemas) do
    Stream.map(schemas, & &1.owner) |> Stream.uniq()
  end

  defp get_feets([]), do: []

  defp get_feets(schemas) do
    Stream.map(schemas, & &1.feets) |> Stream.uniq()
  end

  defp normalize(schemas) do
    schemas
    |> Enum.to_list()
    |> Kernel.inspect()
  end
end
