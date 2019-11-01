defmodule Timesheet.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :note, :string
    field :spend_hours, :integer
    field :job_id, :id
    field :sheet_id, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:spend_hours, :note])
    |> validate_required([:spend_hours, :note])
  end
end
