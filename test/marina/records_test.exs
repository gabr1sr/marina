defmodule Marina.RecordsTest do
  use Marina.DataCase

  alias Marina.Records

  describe "vessels" do
    alias Marina.Records.Vessel

    @valid_attrs %{feets: 42, model: "some model", owner: "some owner", vessel: "some vessel"}
    @update_attrs %{
      feets: 43,
      model: "some updated model",
      owner: "some updated owner",
      vessel: "some updated vessel"
    }
    @invalid_attrs %{feets: nil, model: nil, owner: nil, vessel: nil}

    def vessel_fixture(attrs \\ %{}) do
      {:ok, vessel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Records.create_vessel()

      vessel
    end

    test "list_vessels/0 returns all vessels" do
      vessel = vessel_fixture()
      assert Records.list_vessels() == [vessel]
    end

    test "get_vessel!/1 returns the vessel with given id" do
      vessel = vessel_fixture()
      assert Records.get_vessel!(vessel.id) == vessel
    end

    test "create_vessel/1 with valid data creates a vessel" do
      assert {:ok, %Vessel{} = vessel} = Records.create_vessel(@valid_attrs)
      assert vessel.feets == 42
      assert vessel.model == "some model"
      assert vessel.owner == "some owner"
      assert vessel.vessel == "some vessel"
    end

    test "create_vessel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_vessel(@invalid_attrs)
    end

    test "update_vessel/2 with valid data updates the vessel" do
      vessel = vessel_fixture()
      assert {:ok, %Vessel{} = vessel} = Records.update_vessel(vessel, @update_attrs)
      assert vessel.feets == 43
      assert vessel.model == "some updated model"
      assert vessel.owner == "some updated owner"
      assert vessel.vessel == "some updated vessel"
    end

    test "update_vessel/2 with invalid data returns error changeset" do
      vessel = vessel_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_vessel(vessel, @invalid_attrs)
      assert vessel == Records.get_vessel!(vessel.id)
    end

    test "delete_vessel/1 deletes the vessel" do
      vessel = vessel_fixture()
      assert {:ok, %Vessel{}} = Records.delete_vessel(vessel)
      assert_raise Ecto.NoResultsError, fn -> Records.get_vessel!(vessel.id) end
    end

    test "change_vessel/1 returns a vessel changeset" do
      vessel = vessel_fixture()
      assert %Ecto.Changeset{} = Records.change_vessel(vessel)
    end
  end
end
