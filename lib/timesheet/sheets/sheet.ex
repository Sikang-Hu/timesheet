defmodule Timesheet.Sheets.Sheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sheets" do
    field :approve, :boolean, default: false
    field :date, :date

    belongs_to :worker, Timesheet.Users.User
    has_many :tasks, Timesheet.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(sheet, attrs) do
    sheet
    |> cast(attrs, [:date, :approve, :worker_id])
    |> unique_constraint(:worker_id, name: :sheets_worker_id_date_index)
    |> validate_required([:date, :approve, :worker_id])
  end
end
