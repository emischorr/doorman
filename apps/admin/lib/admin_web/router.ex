defmodule AdminWeb.Router do
  use AdminWeb, :router

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

  pipeline :auth do
    plug AdminWeb.Plug.Authenticate
  end

  scope "/", AdminWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/login", SessionController, :login
    post "/login", SessionController, :create
    get "/logout", SessionController, :logout
  end

  scope "/backend", AdminWeb do
    pipe_through [:browser, :auth]

    get "/", BackendController, :dashboard
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AdminWeb do
  #   pipe_through :api
  # end
end
