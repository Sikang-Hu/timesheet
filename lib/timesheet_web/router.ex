defmodule TimesheetWeb.Router do
  use TimesheetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug TimesheetWeb.Plugs.FetchCurrentUser
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TimesheetWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/sheet/approve", SheetController, :approve
    resources "/sessions", SessionController, 
      only: [:new, :create, :delete], singleton: true
    resources "/sheets", SheetController,
      only: [:new, :show, :index, :create]
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", TimesheetWeb do
  #   pipe_through :api
  # end
end
