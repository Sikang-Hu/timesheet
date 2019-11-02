defmodule Timesheet.Repo.Migrations.CreateSheets do
  use Ecto.Migration

  def change do
    create table(:sheets) do
      add :date, :date
      add :approve, :boolean, default: false, null: false
      add :worker_id, :integer, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:sheets, [:worker_id])
    create unique_index(:sheets, [:worker_id, :date])
  end
end
