defmodule Timesheet.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :job_code, :string
      add :budget, :integer
      add :name, :string
      add :description, :text, default: "N/A"

      timestamps()
    end

  end
end
