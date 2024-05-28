defmodule Marina.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :comment, :string
    field :date, :date
    field :exit_responsible, :string
    field :exit_verified, :boolean, default: false
    field :occurrencies, :string
    field :report_id, :integer
    field :return_responsible, :string
    field :return_verified, :boolean, default: false
    field :stop_responsible, :string
    field :stop_verified, :boolean, default: false
    field :verify_1, :boolean, default: false
    field :verify_10, :boolean, default: false
    field :verify_11, :boolean, default: false
    field :verify_12, :boolean, default: false
    field :verify_2, :boolean, default: false
    field :verify_3, :boolean, default: false
    field :verify_4, :boolean, default: false
    field :verify_5, :boolean, default: false
    field :verify_6, :boolean, default: false
    field :verify_7, :boolean, default: false
    field :verify_8, :boolean, default: false
    field :verify_9, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [
      :date,
      :report_id,
      :verify_1,
      :verify_2,
      :verify_3,
      :verify_4,
      :verify_5,
      :exit_responsible,
      :exit_verified,
      :verify_6,
      :verify_7,
      :verify_8,
      :return_responsible,
      :return_verified,
      :verify_9,
      :verify_10,
      :verify_11,
      :verify_12,
      :stop_responsible,
      :stop_verified,
      :occurrencies,
      :comment
    ])
    |> validate_required([
      :date,
      :report_id,
      :verify_1,
      :verify_2,
      :verify_3,
      :verify_4,
      :verify_5,
      :exit_responsible,
      :exit_verified,
      :verify_6,
      :verify_7,
      :verify_8,
      :return_responsible,
      :return_verified,
      :verify_9,
      :verify_10,
      :verify_11,
      :verify_12,
      :stop_responsible,
      :stop_verified,
      :occurrencies,
      :comment
    ])
  end
end
