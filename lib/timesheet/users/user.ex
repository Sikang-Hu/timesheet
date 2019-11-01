defmodule Timesheet.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :manager_id, :integer, default: -1
    field :name, :string
    field :password_hash, :string

    belongs_to :manager, Timesheet.Users.User
    has_many :workers, Timesheet.Users.User, foreign_key: :manager_id

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager])
    |> validate_required([:email, :name, :manager])
  end
end
