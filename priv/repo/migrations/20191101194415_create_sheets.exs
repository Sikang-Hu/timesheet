defmodule Timesheet.Repo.Migrations.CreateSheets do
  use Ecto.Migration

  def change do
    create table(:sheets) do
      add :date, :date
      add :approve, :boolean, default: false, null: false
      add :worker_id, :integer

      timestamps()
    end

  end
end
