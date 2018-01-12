defmodule ApiWeb.SessionController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def create(conn, %{"user" => user_params}) do
    case Data.User.authenticate(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:success, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:error, "Wrong username or password")
        |> render("login.html", user_params)
    end
  end

  def logout(conn, _params) do
    conn
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end
