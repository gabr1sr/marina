defmodule Marina.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :vessel, :string
      add :model, :string
      add :owner, :string
      add :feets, :string

      timestamps()
    end
  end
end
