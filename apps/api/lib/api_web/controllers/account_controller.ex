defmodule ApiWeb.AccountController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  def create(conn, params) do
    tenant = Data.Tenant.find(params["tenant_code"])
    if (tenant && tenant.allow_subscription) do
      user_params = Map.merge(params, %{"tenant_id" => tenant.id})

      case Data.User.create(user_params) do
        {:ok, user} ->
          IO.inspect user
          render conn, "account_created.json", user: user

        {:error, %Ecto.Changeset{} = changeset} ->
          render conn, "subscription_failed.json", changeset: changeset
      end
    else
      {:error, :unauthorized}
    end
  end

end
