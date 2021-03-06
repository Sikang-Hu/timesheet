defmodule TimesheetWeb.SessionController do
  use TimesheetWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"email" => email, "password" => password}) do
    user = Timesheet.Users.authenticate(email, password)
    if user do
      if user.manager_id == nil do
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back Manager: #{user.email}")
        |> redirect(to: Routes.page_path(conn, :index))
      else 
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back Worker: #{user.email}")
        |> redirect(to: Routes.page_path(conn, :index))
      end
    else
      conn
      |> put_flash(:error, "Login failed.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end