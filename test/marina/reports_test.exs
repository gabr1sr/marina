defmodule Marina.ReportsTest do
  use Marina.DataCase

  alias Marina.Reports

  describe "report" do
    alias Marina.Reports.Report

    @valid_attrs %{
      feets: "some feets",
      model: "some model",
      owner: "some owner",
      vessel: "some vessel"
    }
    @update_attrs %{
      feets: "some updated feets",
      model: "some updated model",
      owner: "some updated owner",
      vessel: "some updated vessel"
    }
    @invalid_attrs %{feets: nil, model: nil, owner: nil, vessel: nil}

    def report_fixture(attrs \\ %{}) do
      {:ok, report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reports.create_report()

      report
    end

    test "list_report/0 returns all report" do
      report = report_fixture()
      assert Reports.list_report() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Reports.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      assert {:ok, %Report{} = report} = Reports.create_report(@valid_attrs)
      assert report.feets == "some feets"
      assert report.model == "some model"
      assert report.owner == "some owner"
      assert report.vessel == "some vessel"
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reports.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      assert {:ok, %Report{} = report} = Reports.update_report(report, @update_attrs)
      assert report.feets == "some updated feets"
      assert report.model == "some updated model"
      assert report.owner == "some updated owner"
      assert report.vessel == "some updated vessel"
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Reports.update_report(report, @invalid_attrs)
      assert report == Reports.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Reports.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Reports.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Reports.change_report(report)
    end
  end
end
