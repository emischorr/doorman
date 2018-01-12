defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    # plug :accepts, ["json"]
    plug :accepts, ["json-api"]
    # Optional
    # plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :api_auth do
    plug Api.AuthAccessPipeline
  end


  scope "/", ApiWeb do
    pipe_through :browser

    get "/login", SessionController, :login
    post "/login", SessionController, :create
    get "/logout", SessionController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", ApiWeb do
  #   pipe_through :api
  # end

  scope "/token", ApiWeb do
    # pipe_through :api

    post "/auth", TokenController, :auth
  end
end
