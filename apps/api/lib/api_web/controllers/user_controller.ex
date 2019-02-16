defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  def subscribe(conn, %{"tenant" => tenant_code}) do
    tenant = Data.Tenant.find(tenant_code)
    case tenant do
      nil ->
        {:error, :not_found}
      %Data.Models.Tenant{} ->
        render(conn, "login.html", tenant: tenant)
    end
  end

  def create(conn, %{"user" => user_params}) do
    tenant = Data.Tenant.find(user_params["tenant_code"])
    if (tenant && tenant.allow_subscription) do
      case Data.User.create(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "User created successfully.")
          |> redirect(to: Routes.user_path(conn, :show, user))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    else
      {:error, :unauthorized}
    end
  end

end
