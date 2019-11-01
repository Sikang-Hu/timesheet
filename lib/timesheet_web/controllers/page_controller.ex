defmodule TimesheetWeb.PageController do
  use TimesheetWeb, :controller

  def index(conn, _params) do
  	user = conn.assigns[:current_user]

  	if user do
  		if user.manager_id do
  			redirect(conn, to: Routes.sheet_path(conn, :index))
  		else
  			redirect(conn, to: Routes.user_path(conn, :index))
  		end
  		
  	else 
  		render(conn, "index.html")
  	end
    
  end
end
