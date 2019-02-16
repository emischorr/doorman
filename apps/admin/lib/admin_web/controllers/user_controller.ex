defmodule AdminWeb.UserController do
  use AdminWeb, :controller

  alias Data.User
  alias Data.Tenant

  def index(conn, _params) do
    users = User.all()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.new()
    render(conn, "new.html", changeset: changeset, tenant_options: Tenant.options)
  end

  def create(conn, %{"user" => user_params}) do
    case User.create(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = User.get(id) |> Data.Repo.preload(:tenant)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    {user, changeset} = User.edit(id)
    render(conn, "edit.html", user: user, changeset: changeset, tenant_options: Tenant.options)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    case User.update(id, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, user, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = User.get_user!(id)
    {:ok, _user} = User.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
