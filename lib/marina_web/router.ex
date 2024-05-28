defmodule MarinaWeb.Router do
  use MarinaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MarinaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MarinaWeb do
    pipe_through :browser

    get "/", MainController, :index
  end

  scope "/reports", MarinaWeb do
    pipe_through :browser

    get "/", ReportController, :index
    get "/new", ReportController, :new
    post "/", ReportController, :create
    get "/:id", ReportController, :show
    get "/:id/edit", ReportController, :edit
    patch "/:id", ReportController, :update
    put "/:id", ReportController, :update
    delete "/:id", ReportController, :delete

    get "/:id/entries", EntryController, :index
    get "/:id/entries/new", EntryController, :new
    post "/:id/entries", EntryController, :create
    get "/:id/entries/:eid", EntryController, :show
    get "/:id/entries/:eid/edit", EntryController, :edit
    patch "/:id/entries/:eid", EntryController, :update
    put "/:id/entries/:eid", EntryController, :update
    delete "/:id/entries/:eid", EntryController, :delete
  end
end
