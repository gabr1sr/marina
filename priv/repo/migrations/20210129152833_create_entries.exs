defmodule Marina.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :date, :date
      add :report_id, :integer
      add :verify_1, :boolean, default: false, null: false
      add :verify_2, :boolean, default: false, null: false
      add :verify_3, :boolean, default: false, null: false
      add :verify_4, :boolean, default: false, null: false
      add :verify_5, :boolean, default: false, null: false
      add :exit_responsible, :string
      add :exit_verified, :boolean, default: false, null: false
      add :verify_6, :boolean, default: false, null: false
      add :verify_7, :boolean, default: false, null: false
      add :verify_8, :boolean, default: false, null: false
      add :return_responsible, :string
      add :return_verified, :boolean, default: false, null: false
      add :verify_9, :boolean, default: false, null: false
      add :verify_10, :boolean, default: false, null: false
      add :verify_11, :boolean, default: false, null: false
      add :verify_12, :boolean, default: false, null: false
      add :stop_responsible, :string
      add :stop_verified, :boolean, default: false, null: false
      add :occurrencies, :string
      add :comment, :string

      timestamps()
    end
  end
end
