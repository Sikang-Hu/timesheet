defmodule Timesheet.Sheets do
  @moduledoc """
  The Sheets context.
  """

  import Ecto.Query, warn: false
  alias Timesheet.Repo

  alias Timesheet.Sheets.Sheet

  @doc """
  Returns the list of sheets.

  ## Examples

      iex> list_sheets()
      [%Sheet{}, ...]

  """
  def list_sheets do
    Repo.all(Sheet)
  end

  def list_sheets_worker(id) do
    query = from(s in Sheet, 
      where: s.worker_id == ^id,
      preload: [:worker]
      )
    Repo.all(query)
  end

  def list_sheets_manager(id) do
    workers = Timesheet.Users.get_workers_id(id)
    query = from(s in Sheet, 
      where: s.worker_id in ^workers,
      preload: [:worker]
      )
    Repo.all(query)
  end

  @doc """
  Gets a single sheet.

  Raises `Ecto.NoResultsError` if the Sheet does not exist.

  ## Examples

      iex> get_sheet!(123)
      %Sheet{}

      iex> get_sheet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sheet!(id), do: Repo.get!(Sheet, id)

  @doc """
  Creates a sheet.

  ## Examples

      iex> create_sheet(%{field: value})
      {:ok, %Sheet{}}

      iex> create_sheet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sheet(attrs \\ %{}) do
    %Sheet{}
    |> Sheet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sheet.

  ## Examples

      iex> update_sheet(sheet, %{field: new_value})
      {:ok, %Sheet{}}

      iex> update_sheet(sheet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sheet(%Sheet{} = sheet, attrs) do
    sheet
    |> Sheet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Sheet.

  ## Examples

      iex> delete_sheet(sheet)
      {:ok, %Sheet{}}

      iex> delete_sheet(sheet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sheet(%Sheet{} = sheet) do
    Repo.delete(sheet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sheet changes.

  ## Examples

      iex> change_sheet(sheet)
      %Ecto.Changeset{source: %Sheet{}}

  """
  def change_sheet(%Sheet{} = sheet) do
    Sheet.changeset(sheet, %{})
  end
end
