defmodule C4diCoffeeWeb.Router do
  use C4diCoffeeWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", C4diCoffeeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/data", PageController, :data
  end

   #Other scopes may use custom stacks.
   scope "/api", C4diCoffeeWeb do
     pipe_through :api
     get "/", SummaryController, :index
     get "/pot_name", SummaryController, :show
   end
end
