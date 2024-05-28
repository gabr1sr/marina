defmodule Marina.EntriesTest do
  use Marina.DataCase

  alias Marina.Entries

  describe "entries" do
    alias Marina.Entries.Entry

    @valid_attrs %{
      comment: "some comment",
      date: "2010-04-17T14:00:00Z",
      exit_responsible: "some exit_responsible",
      exit_verified: true,
      occurrencies: "some occurrencies",
      return_responsible: "some return_responsible",
      return_verified: true,
      stop_responsible: "some stop_responsible",
      stop_verified: true,
      verify_1: true,
      verify_10: true,
      verify_11: true,
      verify_12: true,
      verify_2: true,
      verify_3: true,
      verify_4: true,
      verify_5: true,
      verify_6: true,
      verify_7: true,
      verify_8: true,
      verify_9: true
    }
    @update_attrs %{
      comment: "some updated comment",
      date: "2011-05-18T15:01:01Z",
      exit_responsible: "some updated exit_responsible",
      exit_verified: false,
      occurrencies: "some updated occurrencies",
      return_responsible: "some updated return_responsible",
      return_verified: false,
      stop_responsible: "some updated stop_responsible",
      stop_verified: false,
      verify_1: false,
      verify_10: false,
      verify_11: false,
      verify_12: false,
      verify_2: false,
      verify_3: false,
      verify_4: false,
      verify_5: false,
      verify_6: false,
      verify_7: false,
      verify_8: false,
      verify_9: false
    }
    @invalid_attrs %{
      comment: nil,
      date: nil,
      exit_responsible: nil,
      exit_verified: nil,
      occurrencies: nil,
      return_responsible: nil,
      return_verified: nil,
      stop_responsible: nil,
      stop_verified: nil,
      verify_1: nil,
      verify_10: nil,
      verify_11: nil,
      verify_12: nil,
      verify_2: nil,
      verify_3: nil,
      verify_4: nil,
      verify_5: nil,
      verify_6: nil,
      verify_7: nil,
      verify_8: nil,
      verify_9: nil
    }

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entries.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Entries.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Entries.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Entries.create_entry(@valid_attrs)
      assert entry.comment == "some comment"
      assert entry.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert entry.exit_responsible == "some exit_responsible"
      assert entry.exit_verified == true
      assert entry.occurrencies == "some occurrencies"
      assert entry.return_responsible == "some return_responsible"
      assert entry.return_verified == true
      assert entry.stop_responsible == "some stop_responsible"
      assert entry.stop_verified == true
      assert entry.verify_1 == true
      assert entry.verify_10 == true
      assert entry.verify_11 == true
      assert entry.verify_12 == true
      assert entry.verify_2 == true
      assert entry.verify_3 == true
      assert entry.verify_4 == true
      assert entry.verify_5 == true
      assert entry.verify_6 == true
      assert entry.verify_7 == true
      assert entry.verify_8 == true
      assert entry.verify_9 == true
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Entries.update_entry(entry, @update_attrs)
      assert entry.comment == "some updated comment"
      assert entry.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert entry.exit_responsible == "some updated exit_responsible"
      assert entry.exit_verified == false
      assert entry.occurrencies == "some updated occurrencies"
      assert entry.return_responsible == "some updated return_responsible"
      assert entry.return_verified == false
      assert entry.stop_responsible == "some updated stop_responsible"
      assert entry.stop_verified == false
      assert entry.verify_1 == false
      assert entry.verify_10 == false
      assert entry.verify_11 == false
      assert entry.verify_12 == false
      assert entry.verify_2 == false
      assert entry.verify_3 == false
      assert entry.verify_4 == false
      assert entry.verify_5 == false
      assert entry.verify_6 == false
      assert entry.verify_7 == false
      assert entry.verify_8 == false
      assert entry.verify_9 == false
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, @invalid_attrs)
      assert entry == Entries.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
