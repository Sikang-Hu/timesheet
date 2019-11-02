defmodule TimesheetWeb.SheetController do
  use TimesheetWeb, :controller

  alias Timesheet.Sheets
  alias Timesheet.Sheets.Sheet

  def index(conn, _params) do
    user = conn.assigns[:current_user]
    if user.manager_id do
      sheets = Sheets.list_sheets_worker(user.id)
      render(conn, "index.html", sheets: sheets)
    else
      sheets = Sheets.list_sheets_manager(user.id)
      render(conn, "index.html", sheets: sheets)
    end
  end

  def new(conn, _params) do
    user = conn.assigns[:current_user]
    if user.manager_id do
      changeset = Sheets.change_sheet(%Sheet{})
      jobcodes = Timesheet.Jobs.list_jobcodes()
      render(conn, "new.html", changeset: changeset, jobcodes: jobcodes)
    else
      conn
      |> put_flash(:info, "Approved successfully.")
      |> redirect(to: Routes.sheet_path(conn, :index))
    end
  end

  def create(conn, %{"sheet" => %{
    "date" => date, 
    "hours1" => h1,
    "hours2" => h2,
    "hours3" => h3,
    "hours4" => h4,
    "hours5" => h5,
    "hours6" => h6,
    "hours7" => h7,
    "hours8" => h8,
    "jobcode1" => j1,
    "jobcode2" => j2,
    "jobcode3" => j3,
    "jobcode4" => j4,
    "jobcode5" => j5,
    "jobcode6" => j6,
    "jobcode7" => j7,
    "jobcode8" => j8,
    "desc1" => d1,
    "desc2" => d2,
    "desc3" => d3,
    "desc4" => d4,
    "desc5" => d5,
    "desc6" => d6,
    "desc7" => d7,
    "desc8" => d8,
        }}) do
    hours = [h1, h2, h3, h4, h5, h6, h7, h8]
    jobcodes = [j1, j2, j3, j4, j5, j6, j7, j8]
    descs = [d1, d2, d3, d4, d5, d6, d7, d8]
    h = hours |> Enum.reduce(0, fn h, acc ->  
      case Integer.parse(h, 10) do
        :error ->
          acc
        {i, _} -> if i > 0, do: acc + i, else: acc
      end
    end)
    if h == 8 do
      current_user = conn.assigns[:current_user]
      case Sheets.create_sheet(%{
          worker_id: current_user.id,
          date: date,
        }) do
        {:ok, sheet} -> create_help(conn, sheet, hours, jobcodes, descs)
        {:error, _changeset} -> 
          conn
          |> put_flash(:error, "Only one sheet per day!")
          |> redirect(to: Routes.sheet_path(conn, :new))
      end
    else
      conn
      |> put_flash(:error, "Total hours of tasks should be 8!")
      |> redirect(to: Routes.sheet_path(conn, :new))
    end
  end


  defp create_help(conn, sheet, hrs, js, ns) do
    tasks =
      Enum.map(js, 
        fn jc -> Timesheet.Jobs.get_job_id_by_jobcode(jc) end)
      |> Enum.zip(hrs)
      |> Enum.zip(ns)
      |> Enum.each(fn {{jid, h}, n} -> 
        if h > 0 do
          n = 
          if n == "" do
            "N/A"
          else
            n
          end
          Timesheet.Tasks.create_task(%{
              spend_hours: h,
              note: n,
              job_id: jid,
              sheet_id: sheet.id
            })
        end
       end)
    conn
    |> put_flash(:info, "Sheet created successfully.")
    |> redirect(to: Routes.sheet_path(conn, :show, sheet))
  end

  def show(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet(id)
    tasks = Timesheet.Tasks.get_tasks_by_sheet_id(id)
    render(conn, "show.html", sheet: sheet, tasks: tasks)
  end


  def approve(conn, %{"id" => id}) do
    user = conn.assigns[:current_user]
    if !user.manager_id do
      sheet = Sheets.get_sheet!(id)
      case Sheets.update_sheet(sheet, %{approve: true}) do
        {:ok, sheet} ->
          conn
          |> put_flash(:info, "Approved successfully.")
          |> redirect(to: Routes.sheet_path(conn, :index))

        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_flash(:error, "Approve failed!")
          |> redirect(to: Routes.sheet_path(conn, :index))
      end
    end
  end
end
