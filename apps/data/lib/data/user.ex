defmodule Data.User do
  alias Ecto.Multi

  alias Data.Repo
  alias Data.Models.User

  def all() do
    User |> Repo.all()
  end

  def get(id) do
    User |> User.by_id(id) |> Repo.one()
  end

  def find(login) do
    User |> User.by_login(login) |> Repo.one()
  end

  def new() do
    User.changeset(%User{})
  end

  def create(params) do
    User.changeset(%User{}, params) |> Repo.insert
  end

  def edit(id) do
    user = get(id)
    changeset = User.changeset(user)
    {user, changeset}
  end

  def update(id, params) do
    user = get(id)

    result = Multi.new
    |> Multi.update(:update_user, User.changeset(user, params))
    # |> Multi.run(:update_site, fn(%{update_user: user}) -> Data.Site.update_timestamp(user.site_id) end )
    |> Repo.transaction()

    case result do
      {:ok, %{update_user: user}} ->
        #SiteCache.set(site, "user/#{user.path}", user)
        {:ok, user}
      {:error, changeset} -> {:error, user, changeset}
    end
  end

  def delete(id) do
    get(id) |> Repo.delete
  end

  def authenticate(login_credentials) do
    user = User |> User.active |> User.by_login(login_credentials["login"]) |> Repo.one

    if user && password_correct?(user, login_credentials["password"]) do
      {:ok, user}
    else
      :error
    end
  end

  def password_correct?(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
  end
end
