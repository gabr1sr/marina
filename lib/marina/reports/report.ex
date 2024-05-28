defmodule Marina.Reports.Report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reports" do
    field :feets, :string
    field :model, :string
    field :owner, :string
    field :vessel, :string

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:vessel, :model, :owner, :feets])
    |> validate_required([:vessel, :model, :owner, :feets])
  end
end
