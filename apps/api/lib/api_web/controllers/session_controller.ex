defmodule ApiWeb.SessionController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  def login(conn, %{"tenant" => tenant_code}) do
    tenant = Data.Tenant.find(tenant_code)
    case tenant do
      nil ->
        {:error, :not_found}
      %Data.Models.Tenant{} ->
        render(conn, "login.html", tenant: tenant)
    end
  end

  def create(conn, %{"user" => user_params}) do
    case Data.User.authenticate(user_params, user_params["tenant_code"]) do
      {:ok, user} ->
        conn
        |> put_flash(:success, "Logged in")
        |> redirect(to: "/") # TODO: go to a callback url
      :error ->
        conn
        |> put_flash(:error, "Wrong username or password")
        |> redirect(to: "/login?tenant="<>user_params["tenant_code"])
        # |> render("login.html", user_params)
    end
  end

  def logout(conn, _params) do
    conn
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end
