defmodule AdminWeb.SessionController do
  use AdminWeb, :controller

  action_fallback AdminWeb.FallbackController

  plug :put_layout, "no_session.html"

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def create(conn, %{"user" => user_params}) do
    case Data.User.authenticate(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
        |> put_flash(:success, "Logged in")
        |> redirect(to: "/backend/")
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
