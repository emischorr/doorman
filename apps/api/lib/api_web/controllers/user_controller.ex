defmodule ApiWeb.UserController do
  use ApiWeb, :controller
  
  action_fallback ApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    case Data.User.create(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
