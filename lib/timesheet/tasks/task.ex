defmodule Timesheet.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :note, :string
    field :spend_hours, :integer

    belongs_to :sheet, Timesheet.Sheets.Sheet
    belongs_to :job, Timesheet.Jobs.Job

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:spend_hours, :note, :sheet_id, :job_id])
    |> validate_required([:spend_hours, :note, :sheet_id, :job_id])
  end
end
