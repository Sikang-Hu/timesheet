defmodule TimesheetWeb.PageController do
  use TimesheetWeb, :controller

  def index(conn, _params) do
  	user = conn.assigns[:current_user]

  	if current_user do
  		render(conn, "../sheet/index.html")
  	else 
  		render(conn, "index.html")
  	end
    
  end
end
