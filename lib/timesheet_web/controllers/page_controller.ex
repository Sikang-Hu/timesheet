defmodule TimesheetWeb.PageController do
  use TimesheetWeb, :controller

  def index(conn, _params) do
  	user = conn.assigns[:current_user]

  	if user do
  		redirect(to: Routes.sheet_path(conn, :index))
  	else 
  		render(conn, "index.html")
  	end
    
  end
end
